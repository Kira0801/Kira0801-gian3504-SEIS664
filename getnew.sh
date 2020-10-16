#!/bin/bash

cd ~/repos/node-svc-v1

# pull from 01
scp -r node-user@${NODE_IP_01}:/home/node-user/node-svc-v1/server.js .
scp -r node-user@${NODE_IP_01}:/home/node-user/node-svc-v1/package.json .

#commit
git add . -A
git commit -m "updated server.js"
git push origin 02

# kill and restart 01
rsh node-user@${NODE_IP_01} "sudo pkill 'nodejs'"
rsh node-user@${NODE_IP_01} "sudo pkill 'node'"
#rsh node-user@${NODE_IP_01} "sudo nodejs node-svc-v1/server.js &"

# push to 02 and restart
rsh node-user@${NODE_IP_02} "sudo pkill 'nodejs'"
rsh node-user@${NODE_IP_02} "sudo pkill 'node'"
rsh node-user@${NODE_IP_02} sudo chmod 666 /home/node-user/node-svc-v1/server.js
scp -r ~/repos/node-svc-v1/server.js node-user@${NODE_IP_02}:/home/node-user/node-svc-v1
rsh node-user@${NODE_IP_02} "sudo nodejs node-svc-v1/server.js &"

