FROM fkrull/multi-python:bionic
LABEL maintainer="7119264+albertorios@users.noreply.github.com"

# Never prompt the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

RUN mkdir /python-package
WORKDIR /python-package

#################
# DO STUFF HERE #
#################

# Copy Makefile
COPY Makefile /app/Makefile

# Install
RUN make install

# Copy scripts
COPY scripts/ /app/scripts/

ENTRYPOINT ["/usr/bin/make"]
CMD ["help"]
