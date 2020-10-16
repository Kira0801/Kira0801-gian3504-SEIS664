#!/bin/bash

# install updated terraform and update provisioner 
# only need this as long as Google Cloud Console is behind. 

wget https://releases.hashicorp.com/terraform/0.13.2/terraform_0.13.2_linux_amd64.zip
unzip https://releases.hashicorp.com/terraform/0.13.2/terraform_0.13.2_linux_amd64.zip
mkdir -p ~/bin
mv terraform ~/bin
rm terraform.tfs*
~/bin/terraform init -upgrade
