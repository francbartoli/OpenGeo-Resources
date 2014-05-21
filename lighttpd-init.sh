#!/bin/bash
# Tom Arnold - Walker Associates, Inc.
# 2014-04-14 - CC BY-SA 4.0 as applicable
# http://creativecommons.org/licenses/by-sa/4.0/
# 
# This is a guide for setting up Lighttpd on an Amazon Linux instance.
# Think of it as loose documentation that may easily be turned into a script.
# 
# This is the log file:
LOGFILE="log.lighttpd-init.txt"
echo "--> lighttpd-init.sh --> Beginning initialisation script." | tee $LOGFILE
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
# Install lighttpd
sudo yum -y install lighttpd-fastcgi | tee -a $LOGFILE
echo "--> Configuring Lighttpd" | tee -a $LOGFILE
LIGHTYDIR="./lighttpd"
LIGHTYCONF=$LIGHTYDIR"/port3033.conf"
LIGHTYROOT="/var/www/lighttpd"
mkdir $LIGHTYDIR
#TODO the following works except for literally putting \> in the file
echo server.document-root = \"$LIGHTYROOT\" > $LIGHTYCONF
echo '
server.port = 3033

mimetype.assign = (
  ".html" => "text/html", 
  ".txt" => "text/plain",
  ".jpg" => "image/jpeg",
  ".png" => "image/png" 
)' >> $LIGHTYCONF

