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
namespace FantasyFootball\TournamentAdminBundle\Tests\Services;

use FantasyFootball\TournamentAdminBundle\Services\Csv;
use FantasyFootball\TournamentCoreBundle\Util\{CoachForTest,SquadForTest};
use PHPUnit\Framework\TestCase;

class CsvTest extends TestCase {
    /*
     * @param type $paired Liste d'appariements déjà effectués
     * @param type $toPaired Liste des restants à apparier triée
     * @param type $constraints Liste des appariements interdits
     * @return liste d'appariement satisfaisant les appariements interdits
     */

    public function testFilenameToArrayHappyPath() {
        $expected = [
            [
                'coach_team_name'=>'crazy team',
                'email'=>'crazy@team.org',
                'coach_1_name'=>'crazy_one',
                'coach_1_naf'=>'1',
                'coach_1_race'=>'orc',
                'coach_2_name'=>'crazy_two',
                'coach_2_naf'=>'22',
                'coach_2_race'=>'amazon',
                'coach_3_name'=>'crazy_three',
                'coach_3_naf'=>'333',
                'coach_3_race'=>'human'
            ],
            [
                'coach_team_name'=>'socks_bowl',
                'email'=>'socks@bowl.org',
                'coach_1_name'=>'longshot',
                'coach_1_naf'=>'101',
                'coach_1_race'=>'Wood elf',
                'coach_2_name'=>'trambi',
                'coach_2_naf'=>'99',
                'coach_2_race'=>'Skaven',
                'coach_3_name'=>'biel el jonson',
                'coach_3_naf'=>'0',
                'coach_3_race'=>'orc'
            ]
        ];
        $filepath = \dirname(__FILE__,2).'/load.csv';
        $this->assertFileExists($filepath);
        $result = Csv::filenameToArray($filepath,',');
        $this->assertCount(2, $result);
        $this->assertEquals($expected,$result);
        
    }

    public function testSquadsToHeadersAndRowsHappyPath() {
        $expected = [
            'headers' => [
                'coach_team_name','email',
                'coach_1_name','coach_1_naf','coach_1_race',
                'coach_2_name','coach_2_naf','coach_2_race',
                'coach_3_name','coach_3_naf','coach_3_race'],
            'rows' => [
                [ 
                    'team a', 'a@team.org',
                    'coach 1', 1001,'race1',
                    'coach 2', 1002,'race2',
                    'coach 3', 1003,'race3'
                ],[
                    'team b', 'b@team.org',
                    'coach 4', 1004,'race4',
                    'coach 5', 1005,'race5',
                    'coach 6', 1006,'race6'
                ]
            ]
        ];
        $index = 1;
        $squads = [];
        foreach(['a','b'] as $letter){
            $members = [];
            foreach([1,2,3] as $i){
                $members[] = new CoachForTest("coach $index",1000+$index,"race$index");
                $index++;
            }
            $squads[] = new SquadForTest("team $letter","$letter@team.org",$members);
        }
        $result = Csv::squadsToHeadersAndRows($squads);
        $this->assertCount(2, $result);
        $this->assertEquals($expected,$result);
    }
}