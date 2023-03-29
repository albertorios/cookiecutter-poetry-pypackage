FROM python:3.8.16
LABEL maintainer="{{ cookiecutter.email }}"

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
ENV PYTHONIOENCODING=utf-8
ENV PATH="/root/.local/bin:${PATH}"

RUN mkdir /python-package
WORKDIR /python-package

# Copy files
{% if cookiecutter.license == 'y' -%}
COPY AUTHORS.md ./AUTHORS.md
{% endif %}
{% if cookiecutter.license != 'Proprietary' -%}
COPY LICENSE ./LICENSE
{% endif %}
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
