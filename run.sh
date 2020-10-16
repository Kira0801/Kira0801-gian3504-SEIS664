#!/bin/bash

if [ -z "$NODESVC_V_1" ] 
then
  echo "NODESVC_V_1 is not set"
else
  echo "killing $NODESVC_V_1"
  docker kill $NODESVC_V_1
  unset NODESVC_V_1
  
fi

docker run -d -p 8081:3000 dmacademy/node-svc
docker ps
export NODESVC_V_1=$(docker ps -a | awk 'FNR == 2 {print $NF}') 
echo "exported" $NODESVC_V_1 'to $NODESVC_V_1'
echo "to kill, 'docker kill $NODESVC_V_1'"


