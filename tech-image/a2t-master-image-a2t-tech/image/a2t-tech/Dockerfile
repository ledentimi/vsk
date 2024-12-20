FROM ubuntu:22.04
USER root
ADD pkglist pkglist

# all environment
ENV TZ=Europe/Moscow \
    DEBIAN_FRONTEND=noninteractive \
    SHELL=/bin/bash

# all apt libs
RUN apt-get update && \
    apt-get install -y $(cat pkglist) && \
    apt-get autoremove --purge && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log

# install helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh

# install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
WORKDIR ./app/
