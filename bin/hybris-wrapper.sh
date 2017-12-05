#!/bin/bash
# Exit on first error, print all commands.
#set -ev

#cd ${PLATFORM_HOME}
#source ${PLATFORM_HOME}/setantenv.sh

# if initialize system is wanted we do it before starting the hybris server
if [ "$hyInit" = "y" ]; then
    echo -ne '\n' | ant -f ${PLATFORM_HOME}/build.xml initialize
	ln -sf /hybris/5.7.0.28/hybris/bin/custom/config/local.properties /hybris/5.7.0.28/hybris/config/local.properties
    ln -sf /hybris/5.7.0.28/hybris/bin/custom/config/localextensions.xml /hybris/5.7.0.28/hybris/config/localextensions.xml
	cp -i /tmp/hybrislicence.jar /hybris/5.7.0.28/hybris/config/hybrislicence.jar
    ant clean all
    cp -R /hybris/5.7.0.28/hybris/config /hybris/
fi

# if initialize system is wanted we do it before starting the hybris server
if [ "$hyNewBranch" = "y" ]; then
    ln -sf /hybris/config/ /hybris/5.7.0.28/hybris/config
    cp -i /hybris/5.7.0.28/hybris/bin/custom/config/local.properties /hybris/config/local.properties
    cp -i /hybris/5.7.0.28/hybris/bin/custom/config/localextensions.xml /hybris/config/localextensions.xml
fi

if [ "$hyCopyLocal" = "y" ]; then
    cp -i /hybris/5.7.0.28/hybris/bin/custom/config/local.properties /hybris/config/local.properties
    cp -i /hybris/5.7.0.28/hybris/bin/custom/config/localextensions.xml /hybris/config/localextensions.xml
fi

# if initialize system is wanted we do it before starting the hybris server
if [ "$hyInitSystem" = "y" ]; then
    ant initialize
    cp -R /hybris/5.7.0.28/hybris/config /hybris/
fi

# if for create folder CONFIG is wanted we do it before starting the hybris server
if [ "$hysAnt" = "y" ]; then
    ant all
fi

# if for clear all files is wanted we do it before starting the hybris server
if [ "$hysAntCleanAll" = "y" ]; then
    ant clean all
fi

# set Mock Wire urls
#if [ "$hyWireMock" = "y" ]; then
#    cat /tmp/local.wiremock >> /hybris/5.7.0.28/hybris/config/local.properties
#fi

# if for starting the hybris server
if [ "$hysServer" = "y" ]; then    
    source ${PLATFORM_HOME}/hybrisserver.sh 
fi

# if for starting the hybris server with DEBUG
if [ "$hysServerDebug" = "y" ]; then
    source ${PLATFORM_HOME}/hybrisserver.sh debug
fi
