#!/user/bin/env python3 -tt
"""
Python module to help FantasyFootball API test.
"""
import os

import requests


def check_list_element(url, eltcheck):
    """ Test that <url> returns a list of element
    (checked by <eltcheck>)"""
    response = requests.get(url)
    assert response.status_code == 200
    elements = response.json()
    assert elements
    for element in elements:
        eltcheck(element)


def check_empty_list(url):
    """ Test that <url> returns a dict of elements
    (checked by <eltcheck>)"""
    response = requests.get(url)
    assert response.status_code == 200
    elements = response.json()
    assert type(elements) is list
    assert len(elements) == 0


def check_dict_element(url, eltcheck):
    """ Test that <url> returns a dict of elements
    (checked by <eltcheck>)"""
    response = requests.get(url)
    assert response.status_code == 200
    elements = response.json()
    assert elements
    for key, element in elements.items():
        assert int(key) != 0
        eltcheck(element)


def check_empty_dict(url):
    """ Test that <url> returns a dict of elements
    (checked by <eltcheck>)"""
    response = requests.get(url)
    assert response.status_code == 200
    elements = response.json()
    assert type(elements) is dict
    assert len(elements) == 0


def check_element(url, eltcheck):
    """ Test that <url> returns an element (checked by eltcheck)"""
    response = requests.get(url)
    assert response.status_code == 200
    element = response.json()
    eltcheck(element)


def apirooturl():
    """Return API ROOT URL from environment variable API_ROOT_URL"""
    return os.environ.get("API_ROOT_URL")

def edition():
    """Return EDITION from environment variable EDITION"""
    return os.environ.get("EDITION","1")