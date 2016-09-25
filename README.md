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

## Target project
We built a demo rails application used to do version control and triger git hook. You can find the repository [here](https://github.ncsu.edu/DevOps-Milestones/m1_demo_rails_project).

## Jenkins
### Git installation
 In order to let Jenkins do continuous integration with GitHub, we installed Git on AWS EC2 (`sudo apt-get install git`). Git installation is quite easy, however, at very beginning we did not install Git and an error happened (Jenkins could not run git).
### Set Git executable path
 After installing Git, we need to set the git path in Jenkins. For Jenkins verion 2.7.4, we set the path by going through `Manage Jenkins >Global Tool Configuration > Git> Path to Git executable`.And you can always find the path of Git on your machine by typing `which git`. (Reference: http://stackoverflow.com/questions/8639501/jenkins-could-not-run-git)
### Build and config Jenkins project and GitHub repository
- We built a freestyle Jenkins project named Milestone-rails-project-master. We chose this project is a GitHub project and pasted the corresponding URL (https://github.ncsu.edu/DevOps-Milestones/m1_demo_rails_project.git/).
- For source code management, we chose Git as version control system and pasted the ssh url (https://github.ncsu.edu/DevOps-Milestones/m1_demo_rails_project). After that we generated the public key and private key. Then we  added the private key as Jenkins credential and added public key as repository deploy key. Then for credential dropdown in source code management, we chose the credencial just created. The default branch is master branch, we can specific any other existed branches.
![source code management](https://lh3.googleusercontent.com/fvriC6ch4ou2sCZD4H4Mkh4Q2AaFgL37YeBCoWE0Q7TB4RG23z8OFhvM2rw4wlbMItCTklximQ=w1920-h1080-rw-no)
![Jenkins credential](https://lh3.googleusercontent.com/ULZgAgiaGnz2U2niIItJnC5KfPQVf2I1vysXU2f1UEslL39eyZiqdXjL26ELn_LXTUG5A5WAvA=w1920-h1080-rw-no)
![GitHub repo deploy key](https://lh3.googleusercontent.com/UvYv05x5EqX3EABdeROYaPZpV_eMLdJ-ziMlBgJgNoWsY-AwK5JZc0jLZF5DoC2ycLfmVldM6Q=w1920-h1080-rw-no)
- For build trigger, we chose `Trigger builds remotely` (set token for security purpose) and `Build when a change is pushed to GitHub`. **[screenshots needed]**
- For post-build actions, we enabled email notification. So after each build, we will receive an email about build informations.**[screenshots needed]**
- We also added the `Jenkins (GitHub plugin)` services. It provides improved bi-directional integration with GitHub. Allowing you to set up a Service Hook which will hit your Jenkins instance every time a change is pushed to GitHub. **[further check]**
 
