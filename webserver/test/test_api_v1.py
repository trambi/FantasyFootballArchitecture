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


def test_ranking_coach(apirooturl):
    """ Test that ranking/coach/main/<edition> returns an array of coach"""
    url = apirooturl + "/ranking/coach/main/1"
    response = requests.get(url)
    assert response.status_code == 200
    coachs = response.json()
    assert len(coachs) != 0
    assert coachs[0].get("name") == "coach_29"
    for coach in coachs:
        check_coach(coach)
    