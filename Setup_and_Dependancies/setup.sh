#!/bin/bash
#Install CD
sudo apt update
sudo apt upgrade
cd /media/ubu/VBox_GAs_6.1.48/
sudo ./VBoxLinuxAdditions.run
sudo apt install build-essential linux-headers-$(uname -r) -y
sudo apt install net-tools
sudo apt install openssh-server
sudo apt install git
sudo apt install tmux
sudo apt install mysql-server
sudo apt install python3
sudo apt install pip
pip install pymysql
pip install Flask
pip install plotly
pip install pandas
pip install sqlalchemy
pip install yfinance
pip install mysql-connector-python
mkdir GitClones
cd GitClones/
git clone https://github.com/JackCowling21/CowFund.git