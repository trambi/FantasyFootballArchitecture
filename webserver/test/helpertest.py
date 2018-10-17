#!/user/bin/env python3 -tt
"""
Python module to help FantasyFootball API test.
"""
import os

import requests


def list_element(url, eltcheck):
    """ Test that <url> returns a list of element
    (checked by <eltcheck>)"""
    response = requests.get(url)
    assert response.status_code == 200
    elements = response.json()
    assert elements
    for key, element in elements.items():
        assert int(key) != 0
        eltcheck(element)


def element(url, eltcheck):
    """ Test that <url> returns an element (checked by eltcheck)"""
    response = requests.get(url)
    assert response.status_code == 200
    element = response.json()
    eltcheck(element)


def apirooturl():
    """Return API ROOT URL from environment variable API_ROOT_URL"""
    return os.environ.get("API_ROOT_URL")
