# cookiecutter_poetry_pypackage
[Cookiecutter](https://github.com/cookiecutter/cookiecutter) template for a python package powered by [Poetry](https://python-poetry.org/).

## Why Poetry?
I kept seeing mentions of Poetry online, so I decided to take a weekend to learn about it (and Cookiecutter). The end result is this Cookiecutter template. Poetry is a nifty little tool that can replace and somewhat modernize the traditional Python package development toolset. Instead of using pip, you use Poetry. Instead of using a `setup.py` for building, you use a `pyproject.toml` and Poetry. Instead of twine, you use Poetry.

## What's Included
* Develop, build, and release Python packages using via [Poetry](https://python-poetry.org/)
* Test against multiple Python versions via [Tox](https://tox.readthedocs.io/en/latest/)
* Bump semantic version via [bump2version](https://github.com/c4urself/bump2version)
* Optional command line interface via [Click](https://click.palletsprojects.com/)
* Repeatable build environments via [Docker](https://www.docker.com/)

## Before You Get Started
Make sure to have the following installed:
* Python 3.6+
* Docker

## Generate Python Package
Install latest Cookiecutter:
```
pip install -U cookiecutter
```
Generate Python package:
```
cookiecutter https://github.com/albertorios/cookiecutter-poetry-pypackage.git
```
After generating package (ex. `my_awesome_python_package`), initialize project:
```
cd my_awesome_python_package
make install
```

## Makefile
The included Makefile is at the core of what makes the generated package worth using. Although it's not necessary, I suggest you take some time to read it over.
```
$ make help
help                           Prints all available targets w/ descriptions (Default Target)
clean                          remove all build, test, coverage and Python artifacts
clean-build                    remove build artifacts
clean-pyc                      remove Python file artifacts
clean-test                     remove test and coverage artifacts
poetry-init                    install poetry
poetry-requirements-txt        export dependencies to requirements.txt
poetry-requirements-dev-txt    export dev dependencies to requirements_dev.txt (EXPERIMENTAL)
version-bump-major             bump major version
version-bump-minor             bump minor version
version-bump-patch             bump patch version
lint                           check style with flake8
test                           run tests quickly with the default Python
test-all                       run tests on every Python version with tox
coverage                       check code coverage quickly with the default Python
build                          builds source and wheel package
publish                        package and upload a release
install                        install the package to the active Python's site-packages
docker-build                   build docker container
docker-rm                      delete previously named docker container
docker-run                     runs named docker container
```

### `make install`
`make install` initializes the project by:
* Installing Poetry
 * If you're using a virtualenv, it will install poetry within the virtualenv. Otherwise, it will install poetry system wide.
* Installing dependencies and the generated Python package

NOTE: The default behavior of this command can changed by setting the `ENVIRONMENT` variable from 'development' (default value) to any other value (ex. 'production'). This will install the generated python package via pip and will not install Poetry or the project's dependencies. Example:
```
ENVIRONMENT=production make install
```

### `make test-all`
`make test-all` runs tests against multiple version of Python via tox. In order to avoid having to install all the versions of Python used for testing, the suggested way of running this command is:
```
make docker-build
make docker-run DOCKER_RUN_CMD="test-all"
```

## Should I Use This?
This project is a work in progress, but, as far as I can tell, the generated project *should* be useable. Use at your own risk.

## TODO
* Add tests
* Add CI for both this repo and the generated repo

## Support
This will be semi-regularly maintained by me for my own usage. If there is interest in contributing to this project, I'm open to adding some contributors and/or merging in pull requests.

## Credits
This has been forked and modified from audreyfeldroy's [cookiecutter_pypackage](https://github.com/audreyfeldroy/cookiecutter-pypackage). The original is great, but I wanted to give a shot at customizing it a little more to my liking.
