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

ENV PLATFORM_HOME=/hybris/5.7.0.28/hybris/bin/platform
ENV PATH=$PLATFORM_HOME:$PATH
ENV ANT_HOME=/hybris/5.7.0.28/hybris/bin/platform/apache-ant-1.9.1
ENV PATH=$ANT_HOME/bin:$PATH
ENV TOMCAT_HOME=/hybris/5.7.0.28/hybris/bin/platform/tomcat
ENV PATH=$TOMCAT_HOME:$PATH
ENV CATALINA_HOME=/hybris/5.7.0.28/hybris/bin/platform/tomcat
ENV PATH=$CATALINA_HOME:$PATH

# Update image and install base packages
RUN apk update && \
    apk add curl ca-certificates tar openssl && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /hybris/ && \
    mkdir -p /hybris/5.7.0.28

### Pull Hybris Media in from local path ##
## "---------------------- Starting the hybris commerce suite in the image ---------------------------"
ADD hybris-commerce-suite-5.7.0.28.tar.gz /hybris/5.7.0.28/
### Create directory and unpack Media ##
RUN mkdir /hybris/5.7.0.28/hybris/bin/custom && \
    mkdir /hybris/branches && \
    ## build the platform
    cd ${PLATFORM_HOME} && \
    source ./setantenv.sh

### Copy hybris-wrapper to configure template properties at runtime ##
COPY bin/hybris-wrapper.sh /hybris/5.7.0.28/hybris/bin/platform/hybris-wrapper.sh
#RUN chown -R hybris:hybris /hybris/5.7.0.28/
COPY bin/environment.sh /hybris/5.7.0.28/hybris/bin/platform/environment.sh
## "---------------------- Starting first platform build in the image ---------------------------"

#USER hybris
# "---------------------- Starting first platform build in the image ---------------------------"
# build the platform
#RUN chmod -R 777 /hybris/5.7.0.28/hybris/bin/platform/hybris-wrapper.sh
## Copy in License File##
COPY conf/hybrislicence.jar /tmp/hybrislicence.jar
## COPY wiremock file with all services.
COPY conf/local.wiremock /tmp/local.wiremock
# "---------------------- Starting Ports ---------------------------"
## Expose AJP S-AJP HTTP HTTPS RMI ports ##
EXPOSE 9001 9002 3306 8983 8000 8001 8080 8787 8009 8010 1099 80 22 9999
# "---------------------- Starting Shell Script ---------------------------"
WORKDIR /hybris/5.7.0.28/hybris/bin/platform
