# DevOps-M1
- Jianfeng Chen (jchen37): Build AWS EC2 and install Jenkins;
- Jianbin Chen (jchen45):  Record video;
- Zhewei Hu (zhu6):        Config Jenkins and GitHub.

### Preparation
#### Target Project
We built a demo rails application used to do version control and triger git hook. You can find the repository [here](https://github.ncsu.edu/DevOps-Milestones/m1_demo_rails_project).

####  Install Jenkins
At first, we built an AWS EC2 instance and installed Jenkins on it.
```
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
```
Remember Jenkins uses the port 8080 by default, so we need to open this port. You can access [our server](http://54.205.110.11:8080/) now (username: `admin`, password: `5a8bf4eab5444fcc99cb9bb724fdb0d9`).

#### Git Installation
In order to let Jenkins do continuous integration with GitHub, we installed Git on AWS EC2 (`sudo apt-get install git`). Git installation is quite easy, however, at very beginning we did not install Git and an error happened (Jenkins could not run git).

#### Set Git Executable Path
After installing Git, we need to set the git path in Jenkins. For Jenkins verion 2.7.4, we set the path by going through `Manage Jenkins >Global Tool Configuration > Git> Path to Git executable`.And you can always find the path of Git on your machine by typing `which git`. (Reference: http://stackoverflow.com/questions/8639501/jenkins-could-not-run-git)

### Jenkins and GitHub
#### TASK1: `trigger a build in response to a git commit via a git hook.`  
We created a webhook to trigger Jenkins build jobs. And each time the webhook will send a POST request to Jenkins server to trigger build job when a change is pushed to GitHub.
![Webhook](https://lh3.googleusercontent.com/mbHm-OnrDJ-ouaUeh5ClPtyE6A9UMNAeo1LFxT6jFZmqB9jIat57eU1m5lctRnYWvCAzPzVpyA=w1920-h1080-rw-no)
![POST request](https://lh3.googleusercontent.com/_ihtivGe587N38vKHnfbF4XkRtFVjcUyecpo_Rg6lMuNSkaWL-6fYc38q7RNVjZE3cxrBloSAg=w1920-h1080-rw-no)

#### TASK2: `execute a build job via a script or build manager`  
```
#!/bin/bash
sudo apt-get update
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source /var/lib/jenkins/.rvm/scripts/rvm
ruby -v
gem install rails -v 4.2.6 
rails -v
git clone git@github.ncsu.edu:DevOps-Milestones/m1_demo_rails_project.git
cd m1_demo_rails_project/
bundle install
rake db:migrate RAILS_ENV=test
cp config/secrets.yml.example config/secrets.yml
rake test
```

#### TASK3: `determine failure or success of a build job, and as a result trigger an external event` 

If build job is successful, you will see the console output similar to below, which means all the test cases are passed.
```
# Running:

..............

Finished in 0.333464s, 41.9836 runs/s, 77.9695 assertions/s.

14 runs, 26 assertions, 0 failures, 0 errors, 0 skips
No emails were triggered.
Finished: SUCCESS
```

If the build fails, Jenkins will send email to all developers, which contains all failure information.

#### TASK4: `multiple jobs corresponding to multiple branches`  
We created a job simply by copying from first job. It is because the configurations of these two jobs are almost the same. The only difference is the specified branch.
![Multiple jobs](https://lh3.googleusercontent.com/irvW-Jn3VcrQ2RyKhp9ZkResiXxXpeod3zyVKxaOn3WdIC5f8t_GhbZ6sUdSTKCJ1zY8Tt6CqA=w1920-h1080-rw-no)

#### TASK5: `track and display a history of past builds`  


### Other Config of Jenkins and GitHub
- We built a freestyle Jenkins project named Milestone-rails-project-master. We chose this project is a GitHub project and pasted the corresponding URL (https://github.ncsu.edu/DevOps-Milestones/m1_demo_rails_project.git/).
- For source code management, we chose Git as version control system and pasted the ssh url (https://github.ncsu.edu/DevOps-Milestones/m1_demo_rails_project). After that we generated the public key and private key. Then we  added the private key as Jenkins credential and added public key as repository deploy key. Then for credential dropdown in source code management, we chose the credencial just created. The default branch is master branch, we can specific any other existed branches.
![source code management](https://lh3.googleusercontent.com/fvriC6ch4ou2sCZD4H4Mkh4Q2AaFgL37YeBCoWE0Q7TB4RG23z8OFhvM2rw4wlbMItCTklximQ=w1920-h1080-rw-no)
![Jenkins credential](https://lh3.googleusercontent.com/ULZgAgiaGnz2U2niIItJnC5KfPQVf2I1vysXU2f1UEslL39eyZiqdXjL26ELn_LXTUG5A5WAvA=w1920-h1080-rw-no)
![GitHub repo deploy key](https://lh3.googleusercontent.com/UvYv05x5EqX3EABdeROYaPZpV_eMLdJ-ziMlBgJgNoWsY-AwK5JZc0jLZF5DoC2ycLfmVldM6Q=w1920-h1080-rw-no)
- For build triggers, we chose `Build when a change is pushed to GitHub` for later webhook.
![Build triggers](https://lh3.googleusercontent.com/G29SMycJBR_cGusMKEaZzuyDwA5FkKNEciv96JNSZ95k-2n9fSvKk1xyZrgKYRompf7_AC4ELA=w1920-h1080-rw-no)
- For post-build actions, we enabled email notification. So after each build, we will receive an email about build informations.
![Email](https://lh3.googleusercontent.com/Uh4jxo0wc1U0xtgDtk7Th_HLGqKsUqqhcZEx5YYaiDPigTblRk61BheirX2OFF-rlDlQju59kA=w1920-h1080-rw-no)