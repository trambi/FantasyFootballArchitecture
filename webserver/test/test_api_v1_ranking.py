#!/user/bin/env python3 -tt
"""
Test ranking routes API.
"""

import requests
import pytest

import helpertest


def _test_ranking_elt(url, nameoffirst, eltcheck):
    """ Helper to test that <url> returns an array of element
     (checked by <eltcheck>) and that first element has name <nameoffirst>"""
    response = requests.get(url)
    assert response.status_code == 200
    elts = response.json()
    assert elts
    assert elts[0].get("name") == nameoffirst
    for elt in elts:
        eltcheck(elt)


def check_rank(rank):
    """Test <rank> if a valid rank"""
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
        "opponents",
        "win",
        "draw",
        "loss",
    )
    for key in neededkeys:
        assert rank.get(key) is not None


def test_main_ranking():
    """ Test that ranking/coach/main/<edition> returns an array of coach
    and that first coach is coach_29"""
    url = helpertest.apirooturl() + "/ranking/coach/main/1"
    _test_ranking_elt(url, "coach_29", check_rank)


def _test_ranking_element_by_property(url, eltcheck, propkey):
    """Test that <url> returns an array of element (check by <eltcheck>)
    and that the first element has most property"""
    response = requests.get(url)
    assert response.status_code == 200
    elements = response.json()
    assert elements
    maxprop = 0
    first = elements[0].get(propkey)
    for elt in elements:
        eltcheck(elt)
        current = elt.get(propkey)
        if current > maxprop:
            maxprop = current
    assert maxprop == first


def test_ranking_by_touchdown():
    """ Test that ranking/coach/td/<edition> returns an array of coach
    and the first one has most td"""
    url = helpertest.apirooturl() + "/ranking/coach/td/1"
    _test_ranking_element_by_property(url, check_rank, "tdFor")


def test_ranking_by_casualties():
    """ Test that ranking/coach/casualties/<edition> returns an array of coach
    and the first one has most casualties"""
    url = helpertest.apirooturl() + "/ranking/coach/casualties/1"
    _test_ranking_element_by_property(url, check_rank, "casualtiesFor")


def test_ranking_by_completions():
    """ Test that ranking/coach/completions/<edition> returns an array of coach
    and the first one has most completions"""
    url = helpertest.apirooturl() + "/ranking/coach/completions/1"
    _test_ranking_element_by_property(url, check_rank, "completionsFor")


def test_ranking_by_fouls():
    """ Test that ranking/coach/fouls/<edition> returns an array of coach
    and the first one has most fouls"""
    url = helpertest.apirooturl() + "/ranking/coach/fouls/1"
    _test_ranking_element_by_property(url, check_rank, "foulsFor")


def test_ranking_by_comeback():
    """ Test that ranking/coach/comeback/<edition> returns an array of coach
    and the first one has most win ranks"""
    url = helpertest.apirooturl() + "/ranking/coach/comeback/1"
    _test_ranking_element_by_property(url, check_rank, "diffRanking")


def _test_ranking_element_by_defense(url, eltcheck):
    """ Test that url returns an array of element (checked by <eltcheck>)
    and the first one has least td against """
    response = requests.get(url)
    defencekey = "tdAgainst"
    assert response.status_code == 200
    elements = response.json()
    assert elements
    first = elements[0].get(defencekey)
    bestdefence = first
    for element in elements:
        eltcheck(element)
        current = element.get(defencekey)
        if current < bestdefence:
            bestdefence = current
    assert bestdefence == first


def test_ranking_by_defense():
    """ Test that ranking/coach/defense/<edition> returns an array of coach
    and the first one has least td against """
    url = helpertest.apirooturl() + "/ranking/coach/defense/1"
    _test_ranking_element_by_defense(url, check_rank)


def check_team_rank(teamrank):
    """Test <teamrank> if a valid team rank"""
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
        assert teamrank.get(key) is not None


def test_team_ranking():
    """ Test that ranking/coachTeam/main/<edition> returns an array of coach_team
    and that first coach_team is coach_team_8"""
    url = helpertest.apirooturl() + "/ranking/coachTeam/main/1"
    _test_ranking_elt(url, "coach_team_8", check_team_rank)


def test_team_ranking_by_touchdown():
    """ Test that ranking/coachTeam/td/<edition> returns an array
    of team ranking and the first one has most td"""
    url = helpertest.apirooturl() + "/ranking/coachTeam/td/1"
    _test_ranking_element_by_property(url, check_team_rank, "tdFor")


def test_team_ranking_by_casualties():
    """ Test that ranking/coachTeam/casualties/<edition> returns an array
    of team ranking and the first one has most casualties"""
    url = helpertest.apirooturl() + "/ranking/coachTeam/casualties/1"
    _test_ranking_element_by_property(url, check_team_rank, "casualtiesFor")


def test_team_ranking_by_completions():
    """ Test that ranking/coachTeam/completions/<edition> returns an array
    of team ranking and the first one has most completions"""
    url = helpertest.apirooturl() + "/ranking/coachTeam/completions/1"
    _test_ranking_element_by_property(url, check_team_rank, "completionsFor")


def test_team_ranking_by_fouls():
    """ Test that ranking/coachTeam/fouls/<edition> returns an array
    of team ranking and the first one has most fouls"""
    url = helpertest.apirooturl() + "/ranking/coachTeam/fouls/1"
    _test_ranking_element_by_property(url, check_team_rank, "foulsFor")


def test_team_ranking_by_comeback():
    """ Test that ranking/coachTeam/comeback/<edition> returns an array
    of team ranking and the first one has most win ranks"""
    url = helpertest.apirooturl() + "/ranking/coachTeam/comeback/1"
    _test_ranking_element_by_property(url, check_team_rank, "diffRanking")


def test_team_ranking_by_defense():
    """ Test that ranking/coachTeam/defense/<edition> returns an array
    of team ranking and the first one has least td against """
    url = helpertest.apirooturl() + "/ranking/coachTeam/defense/1"
    _test_ranking_element_by_defense(url, check_team_rank)
