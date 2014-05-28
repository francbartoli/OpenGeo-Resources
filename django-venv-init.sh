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
sudo yum install python-devel
sudo yum -y install gcc
sudo yum --enablerepo=epel install postgresql-devel
sudo yum -y install python-pip
sudo pip install --upgrade pip
sudo pip install virtualenv
# To activate environment: source bin/activate
# To deactivate: deactivate
# For packages specific to a virtual environment,
# Pip install must be done while environment is activated
pip install django
pip install psycopg2
pip install PIL --allow-external PIL --allow-unverified PIL
##NOTE##################
# PIL installed with following notice
# *** TKINTER support not available
# *** JPEG support not available
# *** ZLIB (PNG/ZIP) support not available
# *** FREETYPE2 support not available
# *** LITTLECMS support not available
# --------------------------------------------------------------------
# To add a missing option, make sure you have the required
# library, and set the corresponding ROOT variable in the
# setup.py script.
##########
pip install South
##########
# Check with: which django-admin.py
#cd django-venv
##NOTE##################
# To serve the development server to the internet
# ./manage.py runserver 0.0.0.0:8000
###################
#######
