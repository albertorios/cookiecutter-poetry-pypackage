#!/usr/bin/env python
"""Tests for `{{ cookiecutter.project_slug }}` package."""
import pytest
{%- if cookiecutter.command_line_interface|lower == 'click' %}
from click.testing import CliRunner
{%- endif %}

import {{ cookiecutter.project_slug }}
{%- if cookiecutter.command_line_interface|lower == 'click' %}
from {{ cookiecutter.project_slug }} import cli
{%- endif %}


@pytest.fixture
def dummy_fixture():
    """Dummy fixture to avoid import error."""
    return 'REPLACE ME!'


def test_has_metadata():
    """Test if package has metadata."""
    assert hasattr({{ cookiecutter.project_slug }}, '__author__')
    assert hasattr({{ cookiecutter.project_slug }}, '__email__')
    assert hasattr({{ cookiecutter.project_slug }}, '__version__')
{%- if cookiecutter.command_line_interface|lower == 'click' %}


def test_command_line_interface():
    """Test the CLI."""
    runner = CliRunner()
    result = runner.invoke(cli.main)
    assert result.exit_code == 0
    assert '{{ cookiecutter.project_slug }}.cli.main' in result.output
    help_result = runner.invoke(cli.main, ['--help'])
    assert help_result.exit_code == 0
    assert '--help  Show this message and exit.' in help_result.output
{%- endif %}
