sudo apt update
sudo apt --assume-yes install software-properties-common
sudo apt-add-repository --assume-yes --update ppa:ansible/ansible
sudo apt --assume-yes install ansible
sudo bash -c 'echo "jenkins-server.morro.services.com" > /etc/ansible/hosts'

