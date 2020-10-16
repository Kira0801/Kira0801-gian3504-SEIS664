#!/bin/bash

# NOTE This script MUST be "sourced." You must run it with the "." operator, like this:
# . ./install-node-svc.sh
# In other words, a period, then a space, then the script location (which also starts with a period
# as the script is not in our PATH). 
# NOT like this:
# ./install-node-svc.sh
# We do this because of scoping and environment variables. 

NODE_IP_01=$(gcloud --format="value(networkInterfaces[0].accessConfigs[0].natIP)" compute instances describe node-svc-01) # get IP of VM
rsh ${NODE_IP_01} -l node-user 'mkdir -p ~/node-svc' # make application directory
scp -r server.js node-user@${NODE_IP_01}:~/node-svc/ # copy server script
scp -r package.json node-user@${NODE_IP_01}:~/node-svc/ # copy Node packages
rsh ${NODE_IP_01} -l node-user 'cd ~/node-svc && npm install' # install app
rsh ${NODE_IP_01} -l node-user 'sudo nodejs ~/node-svc/server.js'  # run app 


