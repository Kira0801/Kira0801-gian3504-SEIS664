#!/bin/bash
set -e  # exit immediately if anything returns non-zero. See https://www.javatpoint.com/linux-set-command

echo "  ----- download and initialize app -----  "
git clone https://github.com/dm-academy/node-svc
cd node-svc
git checkout 02

npm install express --save
npm install node-fetch --save
npm install
