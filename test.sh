#!/bin/bash

curl ${NODE_IP_01}:3000
curl ${NODE_IP_01}:3000/1
#curl -X POST -H "Content-Type: application/json"  -d '{"username":"abc" }' ${NODE_IP_01}:3000/1 

