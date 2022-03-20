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
namespace FantasyFootball\TournamentCoreBundle\Entity;


use Doctrine\ORM\EntityRepository;

class CoachTeamRepository  extends EntityRepository {

    public function findByEditionJoined($edition)
    {
        $query = $this->getEntityManager()
            ->createQuery('
                SELECT c, ct FROM FantasyFootballTournamentCoreBundle:CoachTeam ct
                LEFT JOIN ct.coachs c
                WHERE c.edition = :edition'
            )->setParameter('edition', $edition);

        try {
            return $query->getResult();
        } catch (\Doctrine\ORM\NoResultException $e) {
            return null;
        }
    }

    public function deleteByEdition($edition){
        $coachTeams = $this->findByEditionJoined($edition);
        $em = $this->getEntityManager();
        foreach ($coachTeams as $coachTeam){
            foreach($coachTeam->getCoachs() as $coach){
                $coach->setCoachTeam(null);
            }
            $em->remove($coachTeam);
        }
        $em->flush();
    }
    
}
?>