#!/bin/bash

# Check For Root Privileges
if [[ $EUID -ne 0 ]]; then
	echo "Please run this script as root" 1>&2
	exit 1
fi

echo "$(tput setaf 2)[DOCKER INSTALLATION]...$(tput sgr0)";

echo "$(tput setaf 2)[Updating Packages]...$(tput sgr0)";
apt-get update && apt-get upgrade -y;

echo "$(tput setaf 2)[Adding Curl]...$(tput sgr0)";
apt-get install curl;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -;
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";

echo "$(tput setaf 2)[Updating Repositories]...$(tput sgr0)";
apt-get update;

echo "$(tput setaf 2)[Installing Docker Engine]$(tput sgr0)";
apt-get install -y docker-ce;

echo "$(tput setaf 2)[Verifying DOCKER Service Status $(tput setaf 1)(PRESS 'Q' TO CONTINUE)]...$(tput sgr0)";
systemctl status docker;

echo "$(tput setaf 2)[ADDING User to DOCKER Group]...$(tput sgr0)";
usermod -aG docker mav3rick; #[MODIFY... WITH YOUR USERNAME!!!]

echo "$(tput setaf 2)[PULLING TEST DOCKER IMAGE]...$(tput sgr0)";
docker run hello-world;
