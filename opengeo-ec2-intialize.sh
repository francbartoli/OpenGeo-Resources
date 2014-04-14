#!/bin/bash
# Tom Arnold - Walker Associates, Inc.
# 2014-04-14 - CC BY-SA 4.0 as applicable
# http://creativecommons.org/licenses/by-sa/4.0/
# 
# This is a guide for setting up OpenGeo suite (WAR files) on an Amazon Linux instance.
# Think of it as loose documentation that may easily be turned into a script.
# 
# This is the log file:
LOGFILE="log.geoserver-init.txt"
echo "--> geoserver-init.sh --> Beginning initialisation script." | tee $LOGFILE
# Begin by updating the system -- all yum packages
echo "--> Run Yum updates? (answer 'y' to run)"
read PROCEED
if [ "$PROCEED" == 'y' ]; then
  echo "--> Updating using yum update" | tee -a $LOGFILE
  sudo yum -y update | tee -a $LOGFILE
  echo "-->Yum updates complete." | tee -a $LOGFILE
else
  echo "--> Skipping yum updates" | tee -a $LOGFILE
fi
# Amazon Linux already has Java 1.7 installed
echo "--> Beginning installation of JAVA Advanced Imaging API and I/O" | tee -a $LOGFILE
echo "--> Downloading libraries" | tee -a $LOGFILE
wget -N http://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-amd64-jdk.bin
wget -N http://download.java.net/media/jai-imageio/builds/release/1.1/jai_imageio-1_1-lib-linux-amd64-jdk.bin
# The following section is from directions at:
# http://docs.geoserver.org/latest/en/user/production/java.html
# Place JAI in /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.51.x86_64
# Execute bin file with sudo sh jai...
# Need to figure out how to accept license from script
# Install tomcat7
echo "--> Installing Tomcat7" | tee -a $LOGFILE
sudo yum -y install tomcat7 | tee -a $LOGFILE
echo "--> Tomcat complete." | tee -a $LOGFILE
# Download, unzip, install OpenGeo suite WAR files
# OpenGeo/Tomcat7 webapp path
OGF="/usr/share/tomcat7/webapps/"
# WAR file path
WFP="./opengeosuite-f852adb/"
echo "--> Downloading and unzipping OpenGeo WAR files" | tee -a $LOGFILE
sudo wget -N https://dl.dropboxusercontent.com/u/16965407/OpenGeoSuite-4.0.2-war.zip
sudo unzip ./OpenGeoSuite-4.0.2-war.zip
# Uncomment the following line for production:
# sudo rm ./OpenGeoSuite-4.0.2-war.zip
# Ask before installing each WAR file
# Install Dashboard
echo "--> Select OpenGeo suite WAR files for installation."
echo "--> Install Dashboard? (answer 'y' to install)"
read PROCEED
if [ "$PROCEED" == 'y' ]; then
  sudo mv $WFP"dashboard.war" $OGF
  echo "--> Installed Dashboard WAR file." | tee -a $LOGFILE
else
  echo "--> Skipping Dashboard installation" | tee -a $LOGFILE
fi
echo "--> Script complete. See following log file:"
echo $LOGFILE
