#!/user/bin/env python3 -tt
"""
Test edition routes API.
"""

import requests
import pytest

import helpertest


def check_edition(edition):
    """Check if <edition> is a edition"""
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


def test_current_edition():
    """Test that Edition/current return an edition object"""
    url = helpertest.apirooturl() + "/Edition/current"
    helpertest.element(url, check_edition)


def test_list_edition():
    """Test that Editions return a list of edition object"""
    url = helpertest.apirooturl() + "/Editions"
    response = requests.get(url)
    assert response.status_code == 200
    editions = response.json()
    assert editions
    for edition in editions:
        check_edition(edition)


def test_edition_one():
    """Test that Edition/1 return an edition object"""
    url = helpertest.apirooturl() + "/Edition/1"
    helpertest.element(url, check_edition)

