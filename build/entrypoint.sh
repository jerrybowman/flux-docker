#!/bin/bash

cd /home/user/flux

sleep ${STARTUP_SLEEP}

if [ ! -z ${RUN_CONSOLE} ]; then
  exec "./start-opsconsole.sh"
else
  exec "./start-engine.sh"
fi	