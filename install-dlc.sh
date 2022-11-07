#!/bin/bash

# set the vars
INSTALL_OE=true
INSTALL_JAVA=true
scriptpath=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

# get all installers

# Java OpenJDK
if [ $INSTALL_JAVA == "true" ]; then
  rm -rf /opt/java
  mkdir /opt/java
  wget https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.5%2B8/OpenJDK17U-jdk_x64_linux_hotspot_17.0.5_8.tar.gz -P /opt/java
  cd /opt/java
  tar -xzvf OpenJDK17U-jdk_x64_linux_hotspot_17.0.5_8.tar.gz
  ln -s /opt/java/jdk-17.0.5+8 /opt/java/jdk17
  rm -f /opt/java/OpenJDK17U-jdk_x64_linux_hotspot_17.0.5_8.tar.gz
fi


# OpenEdge
if [ $INSTALL_OE == "true" ]; then
  cd $scriptpath
  rm -rf ./oeinstall
  mkdir ./oeinstall
  wget https://github.com/lctkoning/Package-gall/blob/main/PROGRESS_OE_12.6.0_LNX_64.tar.gz?raw=true 
  file=`ls PRO*`
  oeinstaller=${file%\?*}
  mv $file $oeinstaller
  tar -xvzf $oeinstaller -C ./oeinstall
  rm -rf PROGRESS_OE_*
  ./oeinstall/proinst -b ./response.ini -l ./install_oe.log -n
  ln -s /usr/dlc126 /usr/dlc
fi


exit 0

