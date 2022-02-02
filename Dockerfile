FROM ubuntu:20.04

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install gnupg2 wget

# Don't answer questions from postgresql
ARG DEBIAN_FRONTEND=noninteractive

# Install postgresql
RUN apt-get -y update && apt-get -y install software-properties-common postgresql postgresql-client postgresql-contrib
RUN apt install -y ca-certificates


# Setup default user for the tests and a DB
USER postgres

RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
    createdb -O docker db

USER root

RUN apt-get -y install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev git libpq-dev

RUN curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
