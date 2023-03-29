FROM python:3.8.16
LABEL maintainer="7119264+albertorios@users.noreply.github.com"

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
ENV PYTHONIOENCODING=utf-8
ENV PATH="/root/.local/bin:${PATH}"

RUN mkdir /python-package
WORKDIR /python-package

# Copy files
COPY AUTHORS.md ./AUTHORS.md
COPY LICENSE ./LICENSE
COPY README.md ./README.md
COPY cookiecutter.json ./cookiecutter.json
COPY cookiecutter_poetry_pypackage/ ./cookiecutter_poetry_pypackage/
COPY hooks/ ./hooks/
COPY tests/ ./tests/
COPY pyproject.toml ./pyproject.toml
COPY setup.cfg ./setup.cfg
COPY tox.ini ./tox.ini
COPY {{cookiecutter.project_slug}}/ ./{{cookiecutter.project_slug}}/
COPY scripts/ /python-package/scripts/
COPY Makefile /python-package/Makefile

# Install
RUN make install

ENTRYPOINT ["/usr/bin/make"]
CMD ["help"]
