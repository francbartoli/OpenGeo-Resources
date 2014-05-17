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
# Get current directory
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
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
# The following section is from directions at:
# http://docs.geoserver.org/latest/en/user/production/java.html
# 
# Set your JAVA JDK path
JDKP="/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.55.x86_64/"
wget -N "http://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-amd64-jdk.bin" | tee -a $LOGFILE
wget -N "http://download.java.net/media/jai-imageio/builds/release/1.1/jai_imageio-1_1-lib-linux-amd64-jdk.bin" | tee -a $LOGFILE
sudo sed s/+215/-n+215/ ./jai_imageio-1_1-lib-linux-amd64-jdk.bin > ./fixed-jai_imageio-1_1-lib-linux-amd64-jdk.bin
sudo mv ./jai-1_1_3-lib-linux-amd64-jdk.bin $JDKP | tee -a $LOGFILE
sudo mv ./fixed-jai_imageio-1_1-lib-linux-amd64-jdk.bin $JDKP | tee -a $LOGFILE
echo "--> Installing JAI and I/O."
# Fixed install issue by cd to JDKP directory
echo "--> NOTICE!"
echo "--> You must accept licenses for the next two items."
echo "--> After pressing Enter to continue..."
echo "--> Press Q to exit license text and press Y to accept each."
cd $JDKP
sudo sh $JDKP"jai-1_1_3-lib-linux-amd64-jdk.bin"
sudo sh $JDKP"fixed-jai_imageio-1_1-lib-linux-amd64-jdk.bin"
# Return to script dir
cd $SCRIPTDIR
echo "--> JAI and I/O libraries installed." | tee -a $LOGFILE
# Install tomcat7
echo "--> Installing Tomcat7" | tee -a $LOGFILE
sudo yum -y install tomcat7 | tee -a $LOGFILE
echo "--> Tomcat complete." | tee -a $LOGFILE
# Configure tomcat7 to auto start
sudo chkconfig --level 345 tomcat7 on
chkconfig --list | tee -a $LOGFILE
# Download, unzip, install OpenGeo suite WAR files
# OpenGeo/Tomcat7 webapp path
OGF="/usr/share/tomcat7/webapps/"
# WAR file path
WFP="./opengeosuite-f852adb/"
echo "--> Downloading and unzipping OpenGeo WAR files" | tee -a $LOGFILE
#sudo wget -N https://dl.dropboxusercontent.com/u/16965407/OpenGeoSuite-4.0.2-war.zip
sudo wget http://sourceforge.net/projects/geoserver/files/GeoServer/2.5/geoserver-2.5-war.zip/download
# sudo unzip ./OpenGeoSuite-4.0.2-war.zip
# need to rename file properly
# Uncomment the following line for production:
# sudo rm ./OpenGeoSuite-4.0.2-war.zip
# Ask before installing each WAR file
echo "--> Select OpenGeo suite WAR files for installation."
sudo mv "$WFP"version.ini "$OGF"
# Install component
COMP="dashboard"
echo "--> Install" "$COMP""? (answer 'y' to install)"
read PROCEED
if [ "$PROCEED" == 'y' ]; then
  sudo mv "$WFP$COMP".war "$OGF"
  echo "--> Installed "$COMP" WAR file."
else
  echo "--> Skipping "$COMP" installation"
fi
# Install component
COMP="geoserver"
echo "--> Install" "$COMP""? (answer 'y' to install)"
read PROCEED
if [ "$PROCEED" == 'y' ]; then
  sudo mv "$WFP$COMP".war "$OGF"
  echo "--> Installed "$COMP" WAR file."
else
  echo "--> Skipping "$COMP" installation"
fi
# Install component
COMP="geowebcache"
echo "--> Install" "$COMP""? (answer 'y' to install)"
read PROCEED
if [ "$PROCEED" == 'y' ]; then
  sudo mv "$WFP$COMP".war "$OGF"
  echo "--> Installed "$COMP" WAR file."
else
  echo "--> Skipping "$COMP" installation"
fi
# Install component
COMP="geoexplorer"
echo "--> Install" "$COMP""? (answer 'y' to install)"
read PROCEED
if [ "$PROCEED" == 'y' ]; then
  sudo mv "$WFP$COMP".war "$OGF"
  echo "--> Installed "$COMP" WAR file."
else
  echo "--> Skipping "$COMP" installation"
fi
# Install component
COMP="recipes"
echo "--> Install" "$COMP""? (answer 'y' to install)"
read PROCEED
if [ "$PROCEED" == 'y' ]; then
  sudo mv "$WFP$COMP".war "$OGF"
  echo "--> Installed "$COMP" WAR file."
else
  echo "--> Skipping "$COMP" installation"
fi
echo "All OpenGeo WAR files installed" | tee -a $LOGFILE
# Restart Tomcat
echo "--> Stopping Tomcat7" | tee -a $LOGFILE
sudo service tomcat7 stop | tee -a $LOGFILE
# All done now
echo "--> Script complete. See log file: " $LOGFILE