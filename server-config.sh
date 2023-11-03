# sshagent node to be configured with below softwares.
sudo yum install git -y
sudo yum install docker -y
sudo systemctl start docker
# sudo yum install java-1.8.0 -y
# sudo yum install maven -y

if [ -d "addressbook" ]
then
    echo "repo is cloned and exists"
    cd /home/ec2-user/addressbook
    git pull origin AS-55
else
    git clone https://github.com/git-sree/addressbook.git
    cd addressbook
    git checkout AS-55
fi
# mvn package
sudo docker image build -t $1:$2 /home/ec2-user/addressbook