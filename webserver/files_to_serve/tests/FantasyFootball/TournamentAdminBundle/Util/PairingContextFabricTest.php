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
namespace FantasyFootball\TournamentAdminBundle\Tests\Util;

use PHPUnit\Framework\TestCase;
use Doctrine\ORM\EntityManager;
use FantasyFootball\TournamentCoreBundle\DatabaseConfiguration;
use FantasyFootball\TournamentCoreBundle\Entity\Edition;
use FantasyFootball\TournamentAdminBundle\Util\PairingContextFabric;
use FantasyFootball\TournamentAdminBundle\Util\RandomCoachPairingContext;
use FantasyFootball\TournamentAdminBundle\Util\RankedCoachPairingContext;
use FantasyFootball\TournamentAdminBundle\Util\RankedCoachWithFinalePairingContext;
use FantasyFootball\TournamentAdminBundle\Util\RandomCoachTeamPairingContext;
use FantasyFootball\TournamentAdminBundle\Util\RankedCoachTeamPairingContext;
use FantasyFootball\TournamentAdminBundle\Util\RankedCoachTeamWithFinalePairingContext;

class PairingContextFabricTest extends TestCase {
    public function testCreateTeam() {
        $edition = new Edition();
        $edition->setUseFinale(false)
                ->setFullTriplette(true)
                ->setRoundNumber(5)
                ->setCurrentRound(0);
        $em = $this->createMock(EntityManager::class);
        $conf = new DatabaseConfiguration('','','','');
        $pairingContext = PairingContextFabric::create($edition,$em,$conf);
        $this->assertInstanceOf(RandomCoachTeamPairingContext::class,$pairingContext);
        foreach(range(1,4) as $round){
            $edition->setCurrentRound($round);
            $pairingContext = PairingContextFabric::create($edition,$em,$conf);
            $this->assertInstanceOf(RankedCoachTeamPairingContext::class,$pairingContext,"pairing context for $round");
        }
        $edition->setUseFinale(true);
        $pairingContext = PairingContextFabric::create($edition,$em,$conf);
        $this->assertInstanceOf(RankedCoachTeamWithFinalePairingContext::class,$pairingContext);
    }
    public function testCreate() {
        $edition = new Edition();
        $edition->setUseFinale(false)
                ->setFullTriplette(false)
                ->setRoundNumber(5)
                ->setCurrentRound(0);
        $em = $this->createMock(EntityManager::class);
        $conf = new DatabaseConfiguration('','','','');
        $pairingContext = PairingContextFabric::create($edition,$em,$conf);
        $this->assertInstanceOf(RandomCoachPairingContext::class,$pairingContext);
        foreach(range(1,4) as $round){
            $edition->setCurrentRound($round);
            $pairingContext = PairingContextFabric::create($edition,$em,$conf);
            $this->assertInstanceOf(RankedCoachPairingContext::class,$pairingContext,"pairing context for $round");
        }
        $edition->setUseFinale(true);
        $pairingContext = PairingContextFabric::create($edition,$em,$conf);
        $this->assertInstanceOf(RankedCoachWithFinalePairingContext::class,$pairingContext);
    }
}
