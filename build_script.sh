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
