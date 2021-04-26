FROM fkrull/multi-python:bionic
LABEL maintainer="{{ cookiecutter.email }}"

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
ENV PYTHONIOENCODING=utf-8
ENV PATH="${PATH}:/root/.poetry/bin"

RUN mkdir /python-package
WORKDIR /python-package

# Copy files
COPY AUTHORS.md ./AUTHORS.md
COPY LICENSE ./LICENSE
COPY README.md ./README.md
COPY {{cookiecutter.project_slug}}/ ./{{cookiecutter.project_slug}}/
COPY tests/ ./tests/
COPY pyproject.toml ./pyproject.toml
COPY setup.cfg ./setup.cfg
COPY tox.ini ./tox.ini
COPY scripts/ /python-package/scripts/
COPY Makefile /python-package/Makefile

# Install
RUN make install

ENTRYPOINT ["/usr/bin/make"]
CMD ["help"]
