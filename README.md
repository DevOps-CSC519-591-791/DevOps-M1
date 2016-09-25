# DevOps-M1
##  Install Jenkins
At first, we built an AWS EC2 instance and installed Jenkins on it.
```
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
```
Remember Jenkins uses the port 8080 by default, so we need to open this port. You can access [our server](http://54.205.110.11:8080/) now (username: `admin`, password: `5a8bf4eab5444fcc99cb9bb724fdb0d9`).

## Configure Jenkins
 - Git installation
 In order to let Jenkins do continuous integration with GitHub, we installed Git on AWS EC2 (`sudo apt-get install git`). Git installation is quite easy, however, at very beginning we did not install Git and an error happened (Jenkins could not run git).
 -  Set Git path
 After installing Git, we need to set the git path in Jenkins. For Jenkins verion 2.7.4, we set the path by going through `Manage Jenkins >Global Tool Configuration > Git> Path to Git executable`.And you can always find the path of Git on your machine by typing `which git`. (Reference: [http://stackoverflow.com/questions/8639501/jenkins-could-not-run-git](http://stackoverflow.com/questions/8639501/jenkins-could-not-run-git))
