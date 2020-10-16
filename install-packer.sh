#!/bin/bash
# tightly coupled to current packer version, update as necessary

wget https://releases.hashicorp.com/packer/1.5.4/packer_1.5.4_linux_amd64.zip
unzip packer_1.5.4_linux_amd64.zip
mkdir -p ~/bin
mv -f packer ~/bin
rm packer_1.5.4_linux_amd64.zip

echo "either add ~/bin to your path or run as ~/bin/packer"
echo "one way to do this: "
echo "check ~/.bash_profile"
echo "add these lines if they aren't there"
echo "if [ -d "$HOME/bin" ] ; then"
echo "    PATH="$HOME/bin:$PATH""
echo "fi"
