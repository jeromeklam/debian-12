######## INSTALL ########

## Set the base image
FROM debian:12-slim

SHELL ["/bin/bash", "-c"]

## Set environment variables
ENV USER=root
ENV HOME=/root
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=fr_FR.UTF-8
ENV LANGUAGE=C
ENV LC_ALL=C

## Installation des utilitaires de base
RUN apt-get update && apt-get -y install software-properties-common supervisor
RUN apt-get update && apt-get -y install build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get update && apt-get -y install lsb-release ca-certificates wget tzdata curl zip rsync vim nano apt-transport-https dos2unix
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen fr_FR.UTF-8

RUN apt-get install -y python3-launchpadlib

## Installation outils de base
RUN apt-get update && apt-get install -y apt-utils git

## Installation openssl 
COPY docker/install-openssl.sh /tmp
RUN chmod 775 /tmp/install-openssl.sh
RUN /tmp/install-openssl.sh

## Mise à jour
RUN apt-get update && apt-get -y upgrade

## Go and mhsendmail
RUN apt-get update && apt-get install -y golang-go
RUN mkdir /opt/go
ENV GOPATH=/opt/go

## mhsendmail
RUN go install github.com/mailhog/mhsendmail@latest
RUN ln -sf /opt/go/bin/mhsendmail /usr/bin/mhsendmail
RUN ln -sf /opt/go/bin/mhsendmail /usr/bin/sendmail
RUN ln -sf /opt/go/bin/mhsendmail /usr/bin/mail

## TimeZone
RUN echo "Europe/Paris" > /etc/timezone
RUN rm /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

## Set working directory
WORKDIR $HOME