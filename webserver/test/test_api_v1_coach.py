#!/user/bin/env python3 -tt
"""
Test Coach routes API.
"""

import requests
import pytest

import helpertest


def check_coach(coach):
    """Check if <coach> is a coach"""
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


def test_get_coach_list():
    """Test that Coachs/<edition> returns a list of coach object"""
    url = helpertest.apirooturl() + "/Coachs/1"
    helpertest.check_dict_element(url, check_coach)


def test_get_coach():
    """Test that Coach/<id> returns a coach object"""
    url = helpertest.apirooturl() + "/Coach/1"
    helpertest.check_element(url, check_coach)
