#!/bin/bash
#################
# Tom Arnold - Walker Associates, Inc.
# 2014-04-14 - CC BY-SA 4.0 as applicable
# http://creativecommons.org/licenses/by-sa/4.0/
################
# NOTICE!
# This was neither designed nor tested as a script!
################# 
# This is a guide for setting up Virtualenv and Django on an Amazon Linux instance.
# Think of it as loose documentation that may easily be turned into a script.
#################
#Do updates
sudo yum -y update
sudo yum -y install git
# Configure git
# git config --global user.name "yournamehere"
# git config --global user.email "youraddresshere"
sudo yum -y install python-pip
sudo pip install --upgrade pip
sudo pip install virtualenv
#VENV_HOME=/home/ec2-user
##############
# Revised virtualenv to use system site packages
# to get around psycopg2 installation issues
# Todo: verify following line on a clean AMI
##############
sudo yum install python-psycopg2
virtualenv --system-site-packages django-venv
# To activate environment: source ./django-venv/bin/activate
# To deactivate: deactivate
# Pip install must be done while environment is activated
pip install django
# Check with: which django-admin.py
cd django-venv
###################
# Django fails due to missing postgresql-psycopg2
# Tried the following while venv active
# sudo yum install python-devel
# sudo yum install python-psycopg2
# to no avail
##NOTE##################
# To serve the development server to the internet
# ./manage.py runserver 0.0.0.0:8000
###################
#######
# TODO: Turn following notes into code
# This will use Python2.7 in virtualenv in support of Django 1.7
# sudo yum install python27
# virtualenv --python=/usr/bin/python2.7 django-venv