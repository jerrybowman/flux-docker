#!/bin/bash

cd /home/user/flux

sleep ${STARTUP_SLEEP}

if [ ! -z ${RUN_CONSOLE} ]; then
  exec "./start-opsconsole.sh"
elif [ ! -z ${RUN_AGENT} ]; then
  cd config
  cp agent-config.template agent-config.properties
  cd ..
  exec "./start-agent.sh"
else
  exec "./start-engine.sh"
fi	