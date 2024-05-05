#!/bin/bash

sleep 1
cd /tmp
sudo apt install python3-pip -y
sudo python3 -m pip install gdown
export PATH="$HOME/.local/bin:$PATH"
source ~/.bashrc
clear
printf "\n  -> Downloading additional elrond components...\n\n"

# downloading additional tools for elrond
gdown https://drive.google.com/uc?id=1mVrkLp84jchHRrAxqXvSpDdZhIKsH9Fi
if [ -f "elrond-archive.zip" ]; then
    unzip elrond-archive.zip 1> /dev/null
    rm -rf __MACOSX/
else
    printf "\n 'elrond-archive.zip' did not download successfully.\n Exiting. Please run 'sudo /opt/elrond/./make.sh' again."
    exit
fi

#/opt/elrond/elrond/tools/
unzip tools.zip 1> /dev/null
sudo mv avml /opt/elrond/elrond/tools/
sudo mv avml.zip /opt/elrond/elrond/tools/
sudo mv osxpmem.app.zip /opt/elrond/elrond/tools/
sudo mv volatility.zip /opt/elrond/elrond/tools/
sudo mv volatility3.zip /opt/elrond/elrond/tools/

#/opt/elrond/elrond/rivendell/memory/
unzip volatility-sym-prof-plug.zip 1> /dev/null
sudo mv volatility /opt/elrond/elrond/rivendell/memory/
sudo mv volatility3 /opt/elrond/elrond/rivendell/memory/

#/opt/elrond/elrond/rivendell/post/splunk/
unzip apps.zip 1> /dev/null
sudo mkdir /opt/elrond/elrond/rivendell/post/splunk/apps/
sudo mv /tmp/apps/*.py /opt/elrond/elrond/rivendell/post/splunk/apps/
sudo rm -rf /tmp/*.zip
cd ~