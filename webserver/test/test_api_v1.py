#!/user/bin/env python3 -tt
"""
Test Main routes API.
"""

import os
import requests
import pytest


@pytest.fixture
def apirooturl():
    """Fixture to get API_ROOT_URL from environment"""
    return os.environ.get("API_ROOT_URL")


@pytest.fixture
def expectedroutes():
    """Fixture to get all expected routes of API"""
    return {
        "_ws_index": "/ws/index",
        "_ws_version": "/ws/version",
        "_ws_get_editions": "/ws/Editions",
        "_ws_get_edition_list": "/ws/EditionList",
        "_ws_get_current_edition": "/ws/Edition/current",
        "_ws_get_edition": "/ws/Edition/{editionId}",
        "_ws_get_coach_list": "/ws/CoachList/{edition}",
        "_ws_get_coaches": "/ws/Coachs/{edition}",
        "_ws_get_coach": "/ws/Coach/{coachId}",
        "_ws_get_match_list": "/ws/MatchList/{edition}/{round}",
        "_ws_get_matchs": "/ws/Matchs/{edition}/{round}",
        "_ws_get_played_matchs": "/ws/PlayedMatchs/{edition}/{round}",
        "_ws_get_played_match_list": "/ws/PlayedMatchList/{edition}/{round}",
        "_ws_get_to_play_match_list": "/ws/ToPlayMatchList/{edition}/{round}",
        "_ws_get_to_play_matchs": "/ws/ToPlayMatchs/{edition}/{round}",
        "_ws_get_match_list_by_coach": "/ws/MatchListByCoach/{coachId}",
        "_ws_get_matchs_by_coach": "/ws/MatchsByCoach/{coachId}",
        "_ws_get_matchs_by_coach_team": "/ws/MatchsByCoachTeam/{coachTeamId}",
        "_ws_get_match_list_by_coach_team": "/ws/MatchListByCoachTeam/{coachTeamId}",
        "_ws_get_coach_teams": "/ws/CoachTeams/{edition}",
        "_ws_get_coach_team_list": "/ws/CoachTeamList/{edition}",
        "_ws_get_coach_team": "/ws/CoachTeam/{coachTeamId}",
        "_ws_get_main_coach_ranking": "/ws/ranking/coach/main/{edition}",
        "_ws_get_coach_ranking_by_touchdown": "/ws/ranking/coach/td/{edition}",
        "_ws_get_coach_ranking_by_casualties": "/ws/ranking/coach/casualties/{edition}",
        "_ws_get_coach_ranking_by_completions": "/ws/ranking/coach/completions/{edition}",
        "_ws_get_coach_ranking_by_fouls": "/ws/ranking/coach/fouls/{edition}",
        "_ws_get_coach_ranking_by_comeback": "/ws/ranking/coach/comeback/{edition}",
        "_ws_get_coach_ranking_by_defense": "/ws/ranking/coach/defense/{edition}",
        "_ws_get_main_coach_team_ranking": "/ws/ranking/coachTeam/main/{edition}",
        "_ws_get_coach_team_ranking_by_touchdown": "/ws/ranking/coachTeam/td/{edition}",
        "_ws_get_coach_team_ranking_by_casualties": "/ws/ranking/coachTeam/casualties/{edition}",
        "_ws_get_coach_team_ranking_by_completions": "/ws/ranking/coachTeam/completions/{edition}",
        "_ws_get_coach_team_ranking_by_fouls": "/ws/ranking/coachTeam/fouls/{edition}",
        "_ws_get_coach_team_ranking_by_comeback": "/ws/ranking/coachTeam/comeback/{edition}",
        "_ws_get_coach_team_ranking_by_defense": "/ws/ranking/coachTeam/defense/{edition}",
    }


def test_index(apirooturl, expectedroutes):
    """Test the index returns all availables routes"""
    url = apirooturl + "/index"
    response = requests.get(url)
    assert response.status_code == 200
    routes = response.json()
    assert expectedroutes == routes


def test_version(apirooturl):
    """Test that version returns a version object"""
    url = apirooturl + "/version"
    response = requests.get(url)
    assert response.status_code == 200
    version = response.json()
    versionvalue = version.get("version")
    assert versionvalue is not None
    assert versionvalue.startswith("1.")


def check_edition(edition):
    neededkeys = (
        "id",
        "day1",
        "day2",
        "roundNumber",
        "currentRound",
        "useFinale",
        "fullTriplette",
        "rankingStrategyName",
        "rankingStrategy",
        "firstDayRound",
        "rankings",
    )
    for key in neededkeys:
        assert edition.get(key) is not None


def test_current_edition(apirooturl):
    """Test that Edition/current return an edition object"""
    url = apirooturl + "/Edition/current"
    response = requests.get(url)
    assert response.status_code == 200
    edition = response.json()
    check_edition(edition)


def test_list_edition(apirooturl):
    """Test that Editions return a list of edition object"""
    url = apirooturl + "/Editions"
    response = requests.get(url)
    assert response.status_code == 200
    editions = response.json()
    assert len(editions) != 0
    check_edition(editions[0])


def test_edition_one(apirooturl):
    """Test that Edition/1 return an edition object"""
    url = apirooturl + "/Edition/1"
    response = requests.get(url)
    assert response.status_code == 200
    edition = response.json()
    check_edition(edition)


def check_coach(coach):
    neededkeys = (
        "id",
        "teamName",
        "name",
        "raceId",
        "email",
        "ff",
        "reroll",
        "apothecary",
        "assistants",
        "cheerleaders",
        "edition",
        "nafNumber",
        "coachTeamId",
        "raceName",
        "coachTeamName",
        "ready",
    )
    for key in neededkeys:
        assert coach.get(key) is not None


def test_list_coach(apirooturl):
    """Test that Coachs/<edition> returns a list of coach object"""
    url = apirooturl + "/Coachs/1"
    response = requests.get(url)
    assert response.status_code == 200
    coachs = response.json()
    assert len(coachs) != 0
    for id, coach in coachs.items():
        assert int(id) != 0
        check_coach(coach)


def test_coach(apirooturl):
    """Test that Coach/<id> returns a coach object"""
    url = apirooturl + "/Coach/1"
    response = requests.get(url)
    assert response.status_code == 200
    coach = response.json()
    check_coach(coach)


def check_coach_mate(coachmate):
    neededkeys = (
        "coach",
        "coachTeamId",
        "coachTeamName",
        "teamId",
        "teamName",
        "isPrebooking",
    )
    for key in neededkeys:
        assert coachmate.get(key) is not None


def check_coach_team(coachteam):
    neededkeys = ("id", "name", "coachTeamMates")
    for key in neededkeys:
        assert coachteam.get(key) is not None
    for coachmate in coachteam["coachTeamMates"]:
        check_coach_mate(coachmate)


def test_list_coach_team(apirooturl):
    """Test that CoachTeams/<edition> returns a list of coach_team object"""
    url = apirooturl + "/CoachTeams/1"
    response = requests.get(url)
    assert response.status_code == 200
    coachteams = response.json()
    assert len(coachteams) != 0
    for id, coachteam in coachteams.items():
        assert int(id) != 0
        check_coach_team(coachteam)


def test_coach_team(apirooturl):
    """Test that CoachTeam/<id> returns a coach_team object"""
    url = apirooturl + "/CoachTeam/1"
    response = requests.get(url)
    assert response.status_code == 200
    coachteam = response.json()
    check_coach_team(coachteam)


def _test_ranking_elt(url, nameoffirst, eltcheck):
    """ Helper to test that <url> returns an array of element (checked by <eltcheck>)
    and that first element has name <nameoffirst>"""
    response = requests.get(url)
    assert response.status_code == 200
    elts = response.json()
    assert len(elts) != 0
    assert elts[0].get("name") == nameoffirst
    for elt in elts:
        eltcheck(elt)


def test_ranking_coach(apirooturl):
    """ Test that ranking/coach/main/<edition> returns an array of coach
    and that first coach is coach_29"""
    url = apirooturl + "/ranking/coach/main/1"
    _test_ranking_elt(url, "coach_29", check_coach)


def _test_ranking_element_by_property(url, eltcheck, propkey):
    """Test that <url> returns an array of element (check by <eltcheck>)
    and that the first element has most property"""
    response = requests.get(url)
    assert response.status_code == 200
    elements = response.json()
    assert len(elements) != 0
    max = 0
    first = elements[0].get(propkey)
    for elt in elements:
        eltcheck(elt)
        current = elt.get(propkey)
        if current > max:
            max = current
    assert max == first


def test_ranking_coach_by_touchdown(apirooturl):
    """ Test that ranking/coach/td/<edition> returns an array of coach
    and the first one has most td"""
    url = apirooturl + "/ranking/coach/td/1"
    _test_ranking_element_by_property(url, check_coach, "tdFor")


def test_ranking_coach_by_casualties(apirooturl):
    """ Test that ranking/coach/casualties/<edition> returns an array of coach
    and the first one has most casualties"""
    url = apirooturl + "/ranking/coach/casualties/1"
    _test_ranking_element_by_property(url, check_coach, "casualtiesFor")


def test_ranking_coach_by_completions(apirooturl):
    """ Test that ranking/coach/completions/<edition> returns an array of coach
    and the first one has most completions"""
    url = apirooturl + "/ranking/coach/completions/1"
    _test_ranking_element_by_property(url, check_coach, "completionsFor")


def test_ranking_coach_by_fouls(apirooturl):
    """ Test that ranking/coach/fouls/<edition> returns an array of coach
    and the first one has most fouls"""
    url = apirooturl + "/ranking/coach/fouls/1"
    _test_ranking_element_by_property(url, check_coach, "foulsFor")


def test_ranking_coach_by_comeback(apirooturl):
    """ Test that ranking/coach/comeback/<edition> returns an array of coach
    and the first one has most win ranks"""
    url = apirooturl + "/ranking/coach/comeback/1"
    _test_ranking_element_by_property(url, check_coach, "diffRanking")


def test_ranking_coach_by_defense(apirooturl):
    """ Test that ranking/coach/defense/<edition> returns an array of coach
    and the first one has least td against """
    url = apirooturl + "/ranking/coach/defense/1"
    response = requests.get(url)
    defensekey = "tdAgainst"
    assert response.status_code == 200
    coachs = response.json()
    assert len(coachs) != 0
    first = coachs[0].get(defensekey)
    min = first
    for coach in coachs:
        check_coach(coach)
        current = coach.get(defensekey)
        if current < min:
            min = current
    assert min == first


def check_coach_team_rank(coachteam):
    """Test <coachteam> if a valid coach_team rank"""
    neededkeys = (
        "id",
        "name",
        "coachTeamPoints",
        "points",
        "tdFor",
        "tdAgainst",
        "netTd",
        "casualtiesFor",
        "casualtiesAgainst",
        "netCasualties",
        "completionsFor",
        "completionsAgainst",
        "netCompletions",
        "foulsFor",
        "foulsAgainst",
        "netFouls",
        "opponentIdArray",
        "opponentCoachTeamIdArray",
        "teams",
        "opponentsPoints",
        "libre",
        "opponentCoachTeamPoints",
        "win",
        "draw",
        "loss",
        "coachTeamWin",
        "coachTeamDraw",
        "coachTeamLoss",
        "finale",
    )
    for key in neededkeys:
        assert coachteam.get(key) is not None


def test_ranking_coach_team(apirooturl):
    """ Test that ranking/coachTeam/main/<edition> returns an array of coach_team
    and that first coach_team is coach_team_8"""
    url = apirooturl + "/ranking/coachTeam/main/1"
    _test_ranking_elt(url, "coach_team_8", check_coach_team_rank)
