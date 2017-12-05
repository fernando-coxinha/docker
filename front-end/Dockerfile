############################################################
# Dockerfile to build Front-end container images
############################################################
FROM nimmis/java-centos:oracle-8-jdk
# File Author / Maintainer
MAINTAINER Vinicius Pauloci de Moraes <vmoraes1990@gmail.com>
USER root
# "---------------------- Starting update system ---------------------------"
ARG ARG_HTTP_PROXY=default
ARG ARG_HTTPS_PROXY=default

ENV HTTP_PROXY ${ARG_HTTP_PROXY}
ENV HTTPS_PROXY ${ARG_HTTPS_PROXY}
ENV NO_PROXY 'localhost,127.0.0.1'

RUN yum -y update && \
    yum -y install glibc glibc-common openssl-devel wget unzip && \
    curl -sL https://rpm.nodesource.com/setup_9.x | bash - && \
    yum install -y nodejs && \
    npm config set registry=https://registry.npmjs.org/ && \
    npm config set proxy ${HTTP_PROXY} && \
    npm config set https-proxy ${HTTPS_PROXY} && \
    npm install -g gulp-cli && \
    npm install -g nightwatch


# Define working directory.
WORKDIR /webroot/_ui/desktop/common