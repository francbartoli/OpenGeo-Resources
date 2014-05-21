#!/bin/bash
# Tom Arnold - Walker Associates, Inc.
# 2014-04-14 - CC BY-SA 4.0 as applicable
# http://creativecommons.org/licenses/by-sa/4.0/
# 
# This is a guide for setting up Python 2.7 and pip on an Amazon Linux instance.
# Think of it as loose documentation that may easily be turned into a script.
# 
# This is the log file:
LOGFILE="log.python27-init.txt"
echo "--> python27-init.sh --> Beginning initialisation script." | tee $LOGFILE
# Begin by updating the system -- all yum packages
echo "--> Run Yum updates? (answer 'y' to run)"
read PROCEED
if [ "$PROCEED" == 'y' ]; then
  echo "--> Updating using yum update" | tee -a $LOGFILE
  sudo yum -y update | tee -a $LOGFILE
  echo "--> Yum updates complete." | tee -a $LOGFILE
else
  echo "--> Skipping yum updates" | tee -a $LOGFILE
fi
# Install python 2.7
echo "--> Installing Python 2.7" | tee -a $LOGFILE
sudo yum install python27 | tee -a $LOGFILE
# Python 2.6 is default install
# and you will need to run python27 at prompt to invoke 2.7
# Do not be tempted to symlink to the 2.7, you will at least break yum
echo "--> Python 2.7 site-packages installed at:" | tee -a $LOGFILE
python27 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())" | tee -a $LOGFILE
# PYDIR=$(python27 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")

