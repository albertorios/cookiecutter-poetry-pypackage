#!/usr/bin/env python
"""Tests for cookiecutter_poetry_pypackage package."""
import pytest
import cookiecutter_poetry_pypackage


@pytest.fixture
def dummy_fixture():
    """Dummy fixture to avoid import error."""
    return 'REPLACE ME!'


def test_has_metadata():
    """Test if package has metadata."""
    assert hasattr(cookiecutter_poetry_pypackage, '__author__')
    assert hasattr(cookiecutter_poetry_pypackage, '__email__')
    assert hasattr(cookiecutter_poetry_pypackage, '__version__')
