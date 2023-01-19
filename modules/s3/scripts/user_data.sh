sleep 120
sudo yum install -y 
sudo yum install java -y
sudo yum install git -y
sudo yum install maven -y

sudo wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.22.tgz -P /data
sudo tar xzvf /data/docker-20.10.22.tgz -C /data
sudo cp /data/docker/* /usr/bin/
sudo mkdir -p /data/docker_home
sudo dockerd --graph /data/docker_home/ &

sudo wget https://get.jenkins.io/war/2.387/jenkins.war -P /data
sudo mkdir -p /data/jenkins_home 
(cd /data/; sudo ./run.sh -y >> /data/jenkins.txt)