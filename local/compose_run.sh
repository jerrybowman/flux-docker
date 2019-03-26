#!/bin/bash

if [ ! -z ${RUN_DETACHED} ]; then
    DETACHED_PARM="-d"
fi

# We have to delay the startup of the engine and console longer if the database has not
# been initialized. But also allow the user to pick a delay value to override the defaults.

if [ -z ${DELAY} ]; then
	TEST=$(docker volume ls | grep local_flux_pgdata)
    if [ -z $TEST ]; then
        DELAY=60
    else
        DELAY=10
    fi
fi
echo "DELAY:" $DELAY

if [ -z ${ENGINES} ]; then
    ENGINES=1
fi

if [ -z ${AGENTS} ]; then
    AGENTS=0
fi

export STARTUP_SLEEP=${DELAY} 
docker-compose up --scale flux-engine=${ENGINES} --scale flux-agent=${AGENTS} ${DETACHED_PARM}
