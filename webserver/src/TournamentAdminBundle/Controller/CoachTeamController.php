<?php
/*
    FantasyFootball Symfony2 bundles - Symfony2 bundles collection to handle fantasy football tournament 
    Copyright (C) 2017  Bertrand Madet

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
namespace FantasyFootball\TournamentAdminBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

use FantasyFootball\TournamentCoreBundle\Util\DataProvider;
use FantasyFootball\TournamentAdminBundle\Util\DataUpdater;
use Symfony\Component\HttpFoundation\Request;
use FantasyFootball\TournamentCoreBundle\Entity\Coach;
use FantasyFootball\TournamentCoreBundle\Entity\CoachTeam;
use FantasyFootball\TournamentCoreBundle\Entity\RaceRepository;

use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use FantasyFootball\TournamentAdminBundle\Form\CoachTeamType;

use Doctrine\ORM\NoResultException;


class CoachTeamController extends Controller{
  
  public function AddAction(Request $request,$edition){
    $coachTeam = new CoachTeam();
    $em = $this->getDoctrine()->getManager();
    $coachs = $em->getRepository('FantasyFootballTournamentCoreBundle:Coach')
                  ->getQueryBuilderFreeCoachsByEditionAndCoachTeam($edition,0)
                  ->setMaxResults(3)
                  ->getQuery()
                  ->getResult();
    foreach ($coachs as $coach){
      $coachTeam->addCoach($coach);
    }
    $form = $this->createForm(CoachTeamType::class, $coachTeam);
    $form->handleRequest($request);
    if ($form->isValid()) {
      $em->persist($coachTeam);
      $em->flush();
      return $this->redirect($this->generateUrl('fantasy_football_tournament_admin_main',['edition'=>$edition,'round'=>0]));
    }
    return $this->render('@tournament_admin/CoachTeam/Add.html.twig',
      ['form' => $form->createView(),'edition'=> $edition]);
  }

  public function ModifyAction(Request $request,$edition,$coachTeamId){
    $em = $this->getDoctrine()->getManager();
    $coachTeam = $em->getRepository('FantasyFootballTournamentCoreBundle:CoachTeam')
                  ->findOneById($coachTeamId);
    $form = $this->createForm(CoachTeamType::class, $coachTeam);
    foreach($coachTeam->getCoachs() as $coach){
        $coach->setCoachTeam(null);
      }
    $form->handleRequest($request);
    if ($form->isValid()) {
      foreach($coachTeam->getCoachs() as $coach){
        $coach->setCoachTeam($coachTeam);
      }
      $em->flush();
      return $this->redirect($this->generateUrl('fantasy_football_tournament_admin_main',['edition'=>$edition]));
    }
    return $this->render('@tournament_admin/CoachTeam/Modify.html.twig',
      ['form' => $form->createView(),'coachTeam' => $coachTeam,'edition' => $edition]);
    }
  
  public function DeleteAction(Request $request,$coachTeamId){      
    $em = $this->getDoctrine()->getManager();
    $coachTeam = $em->getRepository('FantasyFootballTournamentCoreBundle:CoachTeam')->find($coachTeamId);

    if (!$coachTeam) {
      throw $this->createNotFoundException('Aucun coachTeam trouvé pour cet id : '.$coachTeamId);
    }

    $form = $this->createFormBuilder($coachTeam)
                  ->add('delete',SubmitType::class)
                  ->getForm();

    $form->handleRequest($request);
    //$coachTeam->setId($coachTeamId);
    $edition = 0;
    if ($form->isValid()) {
      foreach($coachTeam->getCoachs() as $coach){
        $coach->setCoachTeam(null);
        $edition = $coach->getEdition();
      }
      $em->remove($coachTeam);
      $em->flush();
      return $this->redirect($this->generateUrl('fantasy_football_tournament_admin_main',['edition'=>$edition]));
    }else{
      foreach($coachTeam->getCoachs() as $coach){
        $edition = $coach->getEdition();
      }
    }
    return $this->render('@tournament_admin/CoachTeam/Delete.html.twig',
      ['coachTeam'=>$coachTeam,'form' => $form->createView(),'edition'=>$edition]);
  }

  protected function convert($filename, $delimiter = ','){
    if( !file_exists($filename) || !is_readable($filename) ) {
        return FALSE;
    }
    $header = NULL;
    $data = array();
    
    if (($handle = fopen($filename, 'r')) !== FALSE) {
      while (($row = fgetcsv($handle, 1000, $delimiter)) !== FALSE) {
        if(!$header) {
          $header = $row;
        } else {
          $data[] = array_combine($header, $row);
        }
      }
      fclose($handle);
    }
    return $data;
  }        

  public function DeleteByEditionAction(Request $request, $edition){
    $em = $this->getDoctrine()->getManager();
    $count = $em->getRepository('FantasyFootballTournamentCoreBundle:Game')->countGamesByEdition($edition);

    if (0 != $count) {
      throw $this->createNotFoundException('Il y a des matchs pour cette edition (id : '.$edition);
    }
    $form = $this->createFormBuilder([])
      ->add('delete',SubmitType::class)
      ->getForm();
    
    $form->handleRequest($request);
    if ($form->isValid()) {
      $em->getRepository('FantasyFootballTournamentCoreBundle:CoachTeam')->deleteByEdition($edition);
      $em->getRepository('FantasyFootballTournamentCoreBundle:Coach')->deleteByEdition($edition);
      $em->flush();
      return $this->redirect($this->generateUrl('fantasy_football_tournament_admin_main',['edition'=>$edition,'round'=>0]));
    }
    return $this->render('@tournament_admin/CoachTeam/DeleteByEdition.html.twig',
      ['form' => $form->createView(),'edition'=>$edition]);
  }
 
  public function LoadAction(Request $request,$edition){
    $loadParameters = array();
    $em = $this->getDoctrine()->getManager();
    $count = $em->getRepository('FantasyFootballTournamentCoreBundle:Game')->countGamesByEdition($edition);
    $formBuilder = $this->createFormBuilder($loadParameters)
      ->add('attachment', FileType::class, array('label'=>'Fichier :'));
    if ( 0 == $count ){
        $formBuilder->add('erase', CheckboxType::class, array('label'=>'Effacer tout ?'));
    }
    $formBuilder = $formBuilder->add('edition', HiddenType::class, array('label'=>'Edition :','data'=>$edition))
      ->add('save',SubmitType::class, array('label'=>'Valider'));
    $form = $formBuilder->getForm();
    $form->handleRequest($request);
    if ($form->isValid()) {
      $file = $form['attachment']->getData();
      $edition = $form['edition']->getData();
      if($form['erase']->getData()){
        $em->getRepository('FantasyFootballTournamentCoreBundle:CoachTeam')->deleteByEdition($edition);
        $em->getRepository('FantasyFootballTournamentCoreBundle:Coach')->deleteByEdition($edition);
      }
      // générer un nom aléatoire et essayer de deviner l'extension (plus sécurisé)
      $extension = $file->guessExtension();
      if ('txt' === $extension) {
        $filename = rand(1, 99999).'.'.$extension;
        $file->move('./', $filename);
        // Getting the CSV from filesystem
        $fileName = './'.$filename;
        $dataArray = $this->convert($fileName, ',');
        
        $defaultRace = $em->getRepository('FantasyFootballTournamentCoreBundle:Race')->findOneById(1);
        foreach($dataArray as $row){
          if('' == $row['coach_team_name']){
            break;
          }
          $coachTeam = new CoachTeam();
          $coachTeam->setName($row['coach_team_name']);
          $em->persist($coachTeam);
          $i = 1;
          while( array_key_exists('coach_'.$i.'_name', $row) )  {
            $coach = new Coach();
            $coach->setCoachTeam($coachTeam);
            if('' != $row['coach_'.$i.'_name']){
              $coach->setName($row['coach_'.$i.'_name']);
            }else{
              $coach->setName($row['coach_team_name'].'_'.$i);
            }
            if('' != $row['coach_'.$i.'_race']){
              $race = trim($row['coach_'.$i.'_race']);
	      $objRace = $em->getRepository('FantasyFootballTournamentCoreBundle:Race')->getRaceByName($race);
	      if(null === $objRace){
	        $coach->setRace($defaultRace);
              }else{
                $coach->setRace($objRace);
              }
            }else{
              $coach->setRace($defaultRace);
            }
            
            $coach->setNafNumber($row['coach_'.$i.'_naf']);
            $coach->setEmail($row['email']);
            $coach->setEdition($edition);
            $i ++;
            $em->persist($coach);
          }
          $em->flush();
        }
      }
      return $this->redirect($this->generateUrl('fantasy_football_tournament_admin_main',['edition'=>$edition,'round'=>0]));
    }

    return $this->render('@tournament_admin/CoachTeam/Load.html.twig',
      ['form' => $form->createView(),'edition' => $edition]);
  }

  public function viewAction($coachTeamId){
    
    $conf = $this->get('fantasy_football_core_db_conf');
    $data = new DataUpdater($conf);
    //$coachTeam = $data->getCoachTeamById($coachTeamId);
    $coachTeam = $this->getDoctrine()
                      ->getRepository('FantasyFootballTournamentCoreBundle:CoachTeam')
                      ->find($coachTeamId);
    $matchs = $data->getMatchsByCoachTeam($coachTeamId);
    $edition = $coachTeam->getCoachs()[0]->getEdition();
    return $this->render('@tournament_admin/CoachTeam/View.html.twig', 
      ['coachTeam'=>$coachTeam,'matchs'=>$matchs,'edition'=>$edition]);
  }

  public function ListAction($edition){
    $coachTeams = $this->getDoctrine()->getRepository('FantasyFootballTournamentCoreBundle:CoachTeam')->findByEditionJoined($edition);
    return $this->render('@tournament_admin/CoachTeam/List.html.twig',
      ['coachTeams' => $coachTeams, 'edition'=>$edition]);
  }
  
  protected function setReadyByEdition($edition, $ready){
    $em = $this->getDoctrine()->getManager();
    $coachs = $em->getRepository('FantasyFootballTournamentCoreBundle:Coach')->findByEdition($edition);
    foreach($coachs as $coach){
      $coach->setReady($ready);
    }
    $em->flush();
  }

  public function ReadyAction($coachTeamId)
  {
    $em = $this->getDoctrine()->getManager();
    $coachTeam = $em->getRepository('FantasyFootballTournamentCoreBundle:CoachTeam')->find($coachTeamId);
    foreach($coachTeam->getCoachs() as $coach){
        $coach->setReady(true);
        $edition = $coach->getEdition();
    }
    $em->flush();
    return $this->redirect($this->generateUrl('fantasy_football_tournament_admin_main',array('edition'=>$edition,'round'=>0)));
  }
  
}
