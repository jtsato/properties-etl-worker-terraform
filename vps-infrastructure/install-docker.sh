sudo apt update

sudo apt install apt-transport-https lsb-release ca-certificates curl gnupg -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt -y install docker-ce docker-ce-cli containerd.io
sudo docker version

sudo systemctl enable docker
sudo systemctl status docker
sudo usermod -aG docker ${USER}
sudo apt update
sudo apt install docker-compose-plugin
sudo systemctl restart docker

sudo docker compose version
