#!/bin/bash
sleep 1
clear
printf "\n  -> Configuring python3.9...\n\n"
yes '' | sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.9 python3.9-venv -y --fix-missing
PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring
sudo git clone https://github.com/harelsegev/INDXRipper /opt/elrond/elrond/tools/INDXRipper
/usr/bin/python3.9 -m pip install --upgrade pip
/usr/bin/python3.8 -m pip install --upgrade pip
/usr/bin/python3 -m pip install --upgrade pip
/usr/bin/python -m pip install --upgrade pip
python3.9 -m pip install setuptools
python3.9 -m pip install construct==2.10.68
python3.8 -m pip install setuptools
python3.8 -m pip install construct==2.10.68
python3 -m pip install construct
python3 -m pip install etl
python3 -m pip install etl-parser
sleep 1