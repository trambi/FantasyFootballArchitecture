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
namespace FantasyFootball\TournamentCoreBundle\Util;

class SquadForTest implements ISquad{
    public $name = '';
    public $email = '';
    public function __construct(string $name,string $email, array $members){
        $this->name = $name;
        $this->email = $email;
        $this->members = $members;
    }
    public function getName(): string{
        return $this->name;
    }
    public function getEmail(): string{
        return $this->email;
    }
    public function getMembers(): array{
        return $this->members;
    }
}

