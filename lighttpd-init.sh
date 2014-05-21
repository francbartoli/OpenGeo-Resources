#!/bin/bash
# Tom Arnold - Walker Associates, Inc.
# 2014-04-14 - CC BY-SA 4.0 as applicable
# http://creativecommons.org/licenses/by-sa/4.0/
# 
# This is a guide for setting up Lighttpd on an Amazon Linux instance.
# Think of it as loose documentation that may easily be turned into a script.
# 
echo "--> lighttpd-init.sh --> Beginning initialisation script."
# Begin by updating the system -- all yum packages
echo "--> Run Yum updates? (answer 'y' to run)"
read PROCEED
if [ "$PROCEED" == 'y' ]; then
  echo "--> Updating using yum update"
  sudo yum -y update
  echo "-->Yum updates complete."
else
  echo "--> Skipping yum updates"
fi
# Install lighttpd
sudo yum -y install lighttpd-fastcgi
# TODO: add configuration notes on how to
# proxy geoserver and django static files
# also need fastcgi notes for Django