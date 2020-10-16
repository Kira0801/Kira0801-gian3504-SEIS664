#!/bin/bash

echo 
echo "#############################"
echo "test script executing default curl localhost:8081"
curl  localhost:8081
echo

echo "test script posting with parameter 1"
echo
curl  -d "1" -X POST localhost:8081 
echo
echo
echo "#############################"
echo
