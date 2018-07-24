#!/bin/bash

## Outside chroot
#Setup crouton chroot
cd ~
sudo ln -s /media/removable/SD\ Card/ sdcard

cd ~/Downloads
sudo sh ~/Downloads/crouton -d -t core,cli-extra,touch,xfce -f ~/Downloads/mybootstrap.tar.bz2
sudo sh ~/Downloads/crouton -t core,cli-extra,touch -a armhf -f ~/Downloads/mybootstrap.tar.bz2 -n xenial

## VScode if used

sudo enter-chroot -n code-oss-chroot
sudo su -i
wget -qO - https://packagecloud.io/headmelted/codebuilds/gpgkey | apt-key add -
tee -a /etc/apt/sources.list.d/codebuilds.list
apt-get update
apt-get install -y code-oss git libibus-1.0-dev

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
wget https://github.com/github/hub/releases/download/v2.4.0/hub-linux-arm64-2.4.0.tgz
tar zvxf hub-linux-arm64-2.5.0.tgz
sudo mv hub-linux-arm64-2.5.0/bin/hub /usr/local/bin/
mv hub-linux-arm64-2.5.0/etc/hub.bash_completion.sh ~/
echo ". $HOME/hub.bash_completion.sh" >> ~/.bash_profile
rm -rf hub-linux-arm64-2.4.0*
echo 'eval "$(hub alias -s)"' >> ~/.bash_profile

#Install pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user
rm -rf get-pip.py

#Install ansible, awscli
pip install --user --upgrade awscli ansible boto boto3

##Personalize
echo

#compile aws-vault