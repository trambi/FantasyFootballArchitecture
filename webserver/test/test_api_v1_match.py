#!/user/bin/env python3 -tt
"""
Test Coach routes API.
"""

import requests
import pytest

import helpertest


def assert_match(match):
    """Assert that <match> is a match
     :param coach object to be a match
    """
    opponentparts = [
        "coach",
        "teamName",
        "teamId",
        "td",
        "casualties",
        "completions",
        "fouls",
        "special",
    ]
    opponentparts1 = [key + "1" for key in opponentparts]
    opponentparts2 = [key + "1" for key in opponentparts]
    neededkeys = (
        ["id", "table", "status", "edition", "round", "finale"]
        + opponentparts1
        + opponentparts2
    )
    assert match
    for key in neededkeys:
        assert match.get(key) is not None


def assert_match_with_expections(match, expectations):
    assert_match(match)
    for key in expectations.keys():
        assert match[key] == expectations[key]


def assert_match_edition_1_round_1(match):
    assert_match_with_expections(match, {"edition": 1, "round": 1})


def assert_played_match_edition_1_round_1(match):
    assert_match_with_expections(match, {"edition": 1, "status": "resume", "round": 1})


def assert_to_play_match_edition_1_round_5(match):
    assert_match_with_expections(
        match, {"edition": 1, "status": "programme", "round": 5}
    )


def assert_match_edition_1_coach_1(match):
    assert_match_with_expections(match, {"edition": 1})
    assert match["teamId1"] == 1 or match["teamId2"] == 1


def test_list_match():
    """Test that Matchs/<edition>/<round> returns a list of match object"""
    url = helpertest.apirooturl() + "/Matchs/1/1"
    helpertest.check_list_element(url, assert_match_edition_1_round_1)


def test_played_matchs():
    """Test that PlayedMatchs/<edition>/<round> returns a list of match object"""
    url = helpertest.apirooturl() + "/PlayedMatchs/1/1"
    helpertest.check_list_element(url, assert_played_match_edition_1_round_1)


def test_to_play_matchs():
    """Test that ToPlayMatchs/<edition>/<round> returns a list of match object"""
    url = helpertest.apirooturl() + "/ToPlayMatchs/1/5"
    helpertest.check_list_element(url, assert_to_play_match_edition_1_round_5)


def test_to_play_matchs_empty():
    """Test that ToPlayMatchs/<edition>/<round> returns a list of match object"""
    url = helpertest.apirooturl() + "/ToPlayMatchs/1/1"
    helpertest.check_empty_list(url)


def test_get_matchs_by_coach():
    """Test that MatchsByCoach/<coachid> returns a list of match object"""
    url = helpertest.apirooturl() + "/MatchsByCoach/1"
    helpertest.check_list_element(url, assert_match_edition_1_coach_1)


def test_get_matchs_by_coach_team():
    """Test that MatchsByCoach/<coachid> returns a list of match object"""
    url = helpertest.apirooturl() + "/MatchsByCoachTeam/1"
    helpertest.check_list_element(url, assert_match)
