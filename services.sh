#!/bin/bash
kubectl apply -f services.yaml
gcloud --format="value(networkInterfaces[0].accessConfigs[0].natIP)" compute instances list --filter="tags.items=node-svc-k8s"
