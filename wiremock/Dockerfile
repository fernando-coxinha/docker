############################################################
# Dockerfile to build Hybris container images
############################################################
FROM anapsix/alpine-java:latest
# File Author / Maintainer
MAINTAINER Vinicius Pauloci de Moraes <vmoraes1990@gmail.com>
USER root
# "---------------------- Starting update system ---------------------------"
ARG ARG_HTTP_PROXY=default
ARG ARG_HTTPS_PROXY=default

ENV HTTP_PROXY ${ARG_HTTP_PROXY}
ENV HTTPS_PROXY ${ARG_HTTPS_PROXY}
ENV NO_PROXY 'localhost,127.0.0.1'

# "---------------------- View settings environment in the image ---------------------------"
# set the PLATFORM_HOME environment variable used by hybris
ENV JAVA_HOME=/usr/java/jdk1.8.0_144
ENV JRE_HOME=/usr/java/jdk1.8.0_144/jre
ENV PATH=$PATH:/usr/java/jdk1.8.0_144/bin:/usr/java/jdk1.8.0_144/jre/bin

RUN mkdir /mock && \
    mkdir /mock/static

COPY ./conf/wiremock-standalone-2.7.1.jar /mock/wiremock-standalone-2.7.1.jar
ADD ./mocks.tar.gz /mock/static/

EXPOSE 8888

WORKDIR /mock

CMD java -jar wiremock-standalone-2.7.1.jar --port 8888 --root-dir static --verbose