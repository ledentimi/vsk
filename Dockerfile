ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}
USER root
COPY sh/* /app/sh/
ADD requirements.txt requirements.txt
ADD pkglist pkglist
RUN chmod +x /app/sh/*.sh

# all environment
ENV TZ=Europe/Moscow \
    DEBIAN_FRONTEND=noninteractive \
    SHELL=/bin/bash

# all apt libs
RUN apt-get update && \
    apt-get install -y $(cat pkglist) && \
    apt-get autoremove --purge && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log

# all pip libs
RUN pip3 install --upgrade setuptools && \
    pip install -r requirements.txt --no-cache-dir && pip freeze > requirements_freeze.pip

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

ADD ./helm-v3.13.0-rc.1-linux-amd64.tar.gz ./helm
RUN mv helm/linux-amd64/helm /usr/local/bin/

WORKDIR ./app/
