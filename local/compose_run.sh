#!/bin/bash

if [ ! -z ${RUN_DETACHED} ]; then
    DETACHED_PARM="-d"
fi

# We have to delay the startup of the engine and console longer if the database has not
# been initialized. But also allow the user to pick a delay value to override the defaults.

if [ -z ${DELAY} ]; then
    if [ -f pgdata/postgresql/.initialized ]; then
        DELAY=10
    else
        DELAY=60
    fi
fi

if [ -z ${ENGINES} ]; then
    ENGINES=1
fi

export STARTUP_SLEEP=${DELAY} 
docker-compose up --scale flux-engine=${ENGINES} ${DETACHED_PARM}
