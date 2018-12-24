#!/bin/bash

# ## Outside chroot
# #Setup crouton chroot
# cd ~
# sudo ln -s /media/removable/SD\ Card/ sdcard

# cd ~/Downloads
# sudo sh ~/Downloads/crouton -d -t core,cli-extra,touch,xfce -f ~/Downloads/mybootstrap.tar.bz2
# sudo sh ~/Downloads/crouton -t core,cli-extra,touch -a armhf -f ~/Downloads/mybootstrap.tar.bz2 -n xenial

# #Inside chroot

# sudo ln -s /media/removable/SD\ Card/movies /movies
# sudo ln -s /media/removable/SD\ Card/git /opt/git
# cp -r /opt/git/private/.bash* /opt/git/private/.gitconfig /opt/git/private/.aws /opt/git/private/.ssh  ~/
# chmod 400 ~/.ssh/id_rsa

# Get latest release function
get_latest() {
    curl -s "https://api.github.com/repos/$1/releases/latest" |
      grep '"tag_name":' |
        sed -E 's/.*"([^"]+)".*/\1/'
}

#Install base packages
sudo apt-get install -y unzip libffi-dev libssl-dev git curl wget python gcc vim groff build-essential dnsutils python-dev libxml2-dev libxslt1-dev

tf_version=$(get_latest hashicorp/terraform | cut -c 2-)
#Install Terraform
wget https://releases.hashicorp.com/terraform/${tf_version}/terraform_${tf_version}_linux_arm.zip
unzip terraform_${tf_version}_linux_arm.zip
chmod +x terraform
sudo mv terraform /usr/local/bin
rm -rf terraform_${tf_version}_linux_arm.zip

#Install hub
hub_version=$(get_latest github/hub | cut -c 2-)
wget https://github.com/github/hub/releases/download/v${hub_version}/hub-linux-arm64-${hub_version}.tgz
tar zvxf hub-linux-arm64-${hub_version}.tgz
sudo mv hub-linux-arm64-${hub_version}/bin/hub /usr/local/bin/
mv hub-linux-arm64-${hub_version}/etc/hub.bash_completion.sh ~/
echo ". $HOME/hub.bash_completion.sh" >> ~/.bash_profile
rm -rf hub-linux-${hub_version}
echo 'eval "$(hub alias -s)"' >> ~/.bash_profile

#Install pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user
rm -rf get-pip.py

#Install ansible, awscli
pip install --user --upgrade awscli ansible boto boto3 pip

##Personalize

# ##AWS-vault
# #compile aws-vault
# sudo apt-get install -y golang-go

# ## Setup environment variables for go
# mkdir ~/go-dir
# export GOPATH="$HOME/go-dir/"

# #compile directly from github
# go get -u github.com/99designs/aws-vault
# sudo mv ~/go-dir/bin/aws-vault /usr/local/bin/
# rm -rf ~/go-dir