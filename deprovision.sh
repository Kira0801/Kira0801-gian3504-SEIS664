#!/bin/bash
gcloud compute instances delete -q node-svc-01
gcloud compute instances delete -q node-svc-02
gcloud compute firewall-rules delete -q allow-node-svc-tcp-3000
