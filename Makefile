.PHONY: help
.PHONY: clean clean-build clean-pyc clean-test clean-dev
.PHONY: poetry-init poetry-requirements-txt poetry-requirements-dev-txt
.PHONY: version-bump-major version-bump-minor version-bump-patch
.PHONY: lint test test-all
.PHONY: build publish install
.PHONY: docker-build docker-rm docker-run
.DEFAULT_GOAL := help

########
# help #
########
help: ## Prints all available targets w/ descriptions (Default Target)
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

#########
# clean #
#########
clean: clean-build clean-pyc clean-test clean-dev ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache

clean-dev: ## remove development artifacts
	rm -f requirements.txt
	rm -f requirements_dev.txt
	rm -f poetry.lock

##########
# poetry #
##########
poetry-init: ## install poetry
	@echo 'Installing poetry...'
	./scripts/install-poetry.sh
	poetry --version

poetry-install: poetry-init
	poetry install

poetry-requirements-txt: ## export dependencies to requirements.txt
	poetry export --without-hashes -f requirements.txt | sed -e 's/;.*//g' > requirements.txt

poetry-requirements-dev-txt: poetry-requirements-txt ## export dev dependencies to requirements_dev.txt (EXPERIMENTAL)
	poetry export --without-hashes --with dev -f requirements.txt | sed -e 's/;.*//g' > requirements_dev.txt
	cat requirements.txt requirements_dev.txt \
	| sort | uniq -u | sed -e "s/==.*//g" \
	| xargs -n 1 -P 8 -I % poetry show % \
	| grep '^name\|^ - ' | tr -s ' ' | cut -s -d' ' -f 3 \
	| sort | uniq \
	| xargs -n 1 -P 8 -I % grep -E "^%==" requirements_dev.txt | sort | uniq > only_dev_reqs.txt
	mv -f only_dev_reqs.txt requirements_dev.txt

###########
# version #
###########
version-bump-major: ## bump major version
	bump2version major
version-bump-minor: ## bump minor version
	bump2version minor
version-bump-patch: ## bump patch version
	bump2version patch

###############
# lint & test #
###############
lint: ## check style with flake8
	poetry run flake8 cookiecutter_poetry_pypackage tests

test: ## run tests quickly with the default Python
	poetry run pytest

test-all: ## run tests on every Python version with tox
	poetry run tox

###################
# build & publish #
###################
POETRY_PYPI_REPO_URL ?= # Set environment variable to override
POETRY_PYPI_TOKEN_PYPI ?= # Set environment variable to use
POETRY_HTTP_BASIC_PYPI_USERNAME ?= # Set environment variable to use
POETRY_HTTP_BASIC_PYPI_PASSWORD ?= # Set environment variable to use

build: clean ## builds source and wheel package
	poetry build

publish: build ## package and upload a release
	poetry config repositories.publish $(POETRY_PRIVATE_REPO_URL) --local
	poetry publish

###########
# install #
###########
ENVIRONMENT ?= development

install:  clean ## install the package to the active Python's site-packages
ifeq ($(ENVIRONMENT), development)
	$(MAKE) poetry-install
else
	pip install .
endif

##########
# docker #
##########
PROJECT_NAME = $(shell poetry version | cut -d ' ' -f 1)
GIT_SHORT_HASH = $(shell git rev-parse --short HEAD)
DOCKER_RUN_CMD ?= help

docker-build:  ## build docker container
	docker build -t $(PROJECT_NAME) .

docker-rm: ## delete previously named docker container
	@echo 'Removing previous containers...'
	docker rm $(GIT_SHORT_HASH) &>/dev/null || echo 'No previous containers found.'

docker-run: docker-rm  ## runs named docker container
	docker run --name $(GIT_SHORT_HASH) \
		-e POETRY_PYPI_REPO_URL=$(POETRY_PYPI_REPO_URL) \
		-e POETRY_PYPI_TOKEN_PYPI=$(POETRY_PYPI_TOKEN_PYPI) \
		-e POETRY_HTTP_BASIC_PYPI_USERNAME=$(POETRY_HTTP_BASIC_PYPI_USERNAME) \
		-e POETRY_HTTP_BASIC_PYPI_PASSWORD=$(POETRY_HTTP_BASIC_PYPI_PASSWORD) \
		-i $(PROJECT_NAME) $(DOCKER_RUN_CMD)
