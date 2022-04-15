<?php
/*
    FantasyFootball Symfony3 bundles - Symfony3 bundles collection to handle fantasy football tournament 
    Copyright (C) 2022  Bertrand Madet

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
namespace FantasyFootball\TournamentAdminBundle\Services;

use FantasyFootball\TournamentCoreBundle\Utils\{ICoach,ISquad};
use FantasyFootball\TournamentCoreBundle\Entity\Game;

class Csv{

 public static function filenameToArray(string $filename, string $delimiter = ','){
    if( !file_exists($filename) || !is_readable($filename) ) {
        return FALSE;
    }
    $header = NULL;
    $data = array();
    
    if (($handle = fopen($filename, 'r')) !== FALSE) {
      while (($row = fgetcsv($handle, 1000, $delimiter)) !== FALSE) {
        $trimmedRow = array_map('trim',$row);
        if(!$header) {
          $header = $trimmedRow;
        } else {
          $data[] = array_combine($header, $trimmedRow);
        }
      }
      fclose($handle);
    }
    return $data;
  }

  public static function maxMembers(int $max,$current){
    $currentNumber = count($current->getMembers()); 
    return $max < $currentNumber ? $currentNumber : $max;
  }

  protected static function getMaxNumberMembers($squads){
    return array_reduce($squads,'self::maxMembers',0);
  }

  public static function squadsToHeadersAndRows(array $squads): array{
    $maxMembers = self::getMaxNumberMembers($squads);
    return [
      'headers' => create_headers_for_squad($maxMembers),
      'rows' => create_rows_for_squad($squads,$maxMembers)
    ];
  }

  public static function gamesToHeadersAndRows(array $games): array{
    return [
      'headers' => self::createHeadersForGame(),
      'rows' => self::createRowsFromGames($games)
    ];
  }

  protected static function createHeadersForGame(): array {
    return [
      'round','table','finale',
      'coach_team_1','coach_1_name','points_1',
      'td_1','casualties_1','completions_1','fouls_1','special_1',
      'coach_team_2','coach_2_name','points_2',
      'td_2','casualties_2','completions_2','fouls_2','special_2'
    ];
  }

  protected static function createRowsFromGames(array $games): array{
    return array_map(function (Game $game){
      $coach1 = $game->getCoach1();
      $coach2 = $game->getCoach2();
      return [
        $game->getRound(),$game->getTableNumber(),$game->getFinale(),
        $coach1->getCoachTeam()->getName(),$coach1->getName(),$game->getPoints1(),
        $game->getTd1(),$game->getCasualties1(),$game->getCompletions1(),
        $game->getFouls1(),$game->getSpecial1(),
        $coach2->getCoachTeam()->getName(),$coach2->getName(),$game->getPoints2(),
        $game->getTd2(),$game->getCasualties2(),$game->getCompletions2(),
        $game->getFouls2(),$game->getSpecial2(),
      ];
    },$games);  
  }
}

function create_headers_for_squad(int $maxMembers){
  $headers = ['coach_team_name','email'];
  foreach (range(1,$maxMembers) as $i){
    $headers[] = "coach_${i}_name";
    $headers[] = "coach_${i}_naf";
    $headers[] = "coach_${i}_race"; 
  }
  return $headers;
}

function create_rows_for_squad(array $squads,int $maxMembers){
  return array_map(function ($squad){
    $row = [$squad->getName(),$squad->getEmail()];
    foreach($squad->getMembers() as $coach){
      $row[] = $coach->getName();
      $row[] = $coach->getNafNumber();
      $row[] = $coach->getRaceName();
    }
    return $row;
  },$squads);
}

