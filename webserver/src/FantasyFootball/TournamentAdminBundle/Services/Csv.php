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

  public static function squadsToHeadersAndRows(array $squads): array{
    $maxMembers = get_max_number_members($squads);
    return [
      'headers' => create_headers_for_squad($maxMembers),
      'rows' => create_rows_for_squad($squads,$maxMembers)
    ];
  }
}

function max_members(int $max,ISquad $current){
  $currentNumber = count($current->getMembers()); 
  return $max < $currentNumber ? $currentNumber : $max;
}

function get_max_number_members($squads){
  return array_reduce($squads,function (int $max,$current){
    $currentNumber = count($current->getMembers());
    return $max < $currentNumber ? $currentNumber : $max;
  },0);
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

