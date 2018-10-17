#!/bin/bash

## Outside chroot
#Setup crouton chroot
cd ~
sudo ln -s /media/removable/SD\ Card/ sdcard

cd ~/Downloads
sudo sh ~/Downloads/crouton -d -t core,cli-extra,touch,xfce -f ~/Downloads/mybootstrap.tar.bz2
sudo sh ~/Downloads/crouton -t core,cli-extra,touch -a armhf -f ~/Downloads/mybootstrap.tar.bz2 -n xenial

#Inside chroot

sudo ln -s /media/removable/SD\ Card/movies /movies
sudo ln -s /media/removable/SD\ Card/git /opt/git
cp -r /opt/git/private/.bash* /opt/git/private/.gitconfig /opt/git/private/.aws /opt/git/private/.ssh  ~/
chmod 400 ~/.ssh/id_rsa


#Install Terraform
sudo apt-get install -y unzip libffi-dev libssl-dev git curl wget python gcc vim groff build-essential dnsutils python-dev libxml2-dev libxslt1-dev
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_arm.zip
unzip terraform_0.11.7_linux_arm.zip
chmod +x terraform
sudo mv terraform /usr/local/bin
rm -rf terraform_0.11.7_linux_arm.zip

#Install hub
wget https://github.com/github/hub/releases/download/v2.5.1/hub-linux-arm64-2.5.1.tgz
tar zvxf hub-linux-arm64-*
sudo mv hub-linux-arm64-2.*/bin/hub /usr/local/bin/
mv hub-linux-arm64-*/etc/hub.bash_completion.sh ~/
echo ". $HOME/hub.bash_completion.sh" >> ~/.bash_profile
rm -rf hub-linux-**
echo 'eval "$(hub alias -s)"' >> ~/.bash_profile

#Install pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user
rm -rf get-pip.py

#Install ansible, awscli
pip install --user --upgrade awscli ansible boto boto3

##Personalize

##AWS-vault
#compile aws-vault
sudo apt-get install -y golang-go

## Setup environment variables for go
mkdir ~/go-dir
export GOPATH="$HOME/go-dir/"

#compile directly from github
go get -u github.com/99designs/aws-vault
sudo mv ~/go-dir/bin/aws-vault /usr/local/bin/
rm -rf ~/go-dir