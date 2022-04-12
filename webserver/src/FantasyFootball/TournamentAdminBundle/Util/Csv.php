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
namespace FantasyFootball\TournamentAdminBundle\Util;


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
}