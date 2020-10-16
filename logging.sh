#!/bin/bash
kubectl get pods --all-namespaces
# change the below
kubectl -n default logs node-svc-deployment-6c495fc4d-56x5p   
