#!/user/bin/env python3 -tt
"""
Test CoachTeam routes API.
"""

import requests
import pytest

import helpertest


def check_coach_mate(coachmate):
    """Check if <coachmate> is a coachmate"""
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
    """Check if <coachteam> is a coach_team"""
    neededkeys = ("id", "name", "coachTeamMates")
    for key in neededkeys:
        assert coachteam.get(key) is not None
    for coachmate in coachteam["coachTeamMates"]:
        check_coach_mate(coachmate)


def test_list_coach_team():
    """Test that CoachTeams/<edition> returns a list of coach_team object"""
    url = helpertest.apirooturl() + "/CoachTeams/1"
    helpertest.list_element(url, check_coach_team)


def test_coach_team():
    """Test that CoachTeam/<id> returns a coach_team object"""
    url = helpertest.apirooturl() + "/CoachTeam/1"
    helpertest.element(url, check_coach_team)
