#!/bin/bash


#Install Terraform
sudo apt-get install -y unzip wget libffi-dev libssl-dev git curl python gcc vim build-essential
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_arm.zip
unzip terraform_0.11.7_linux_arm.zip
chmod +x terraform
sudo mv terraform /usr/local/bin

#Install hub
wget https://github.com/github/hub/releases/download/v2.4.0/hub-linux-arm64-2.4.0.tgz
tar zvxf hub-linux-arm64-2.4.0.tgz
sudo mv hub-linux-arm64-2.4.0/bin/hub /usr/local/bin/
mv hub-linux-arm64-2.4.0/etc/hub.bash_completion.sh ~/
echo ". $HOME/hub.bash_completion.sh" >> ~/.bash_profile

#Install pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user
rm -rf get-pip.py

#Install ansible, awscli
pip install --user awscli ansible
