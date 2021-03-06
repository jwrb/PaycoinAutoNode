#!/bin/bash
echo "### Changing to paycoind directory"
cd ~
echo "### Stopping Paycoin Server"
./paycoind stop
echo "### Changing to home directory"
cd ~
echo "### Updating Ubuntu"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install python-pip apache2 -y
echo "### Allow ports 80, 8999 and enable The Uncomplicated Firewall"
sudo ufw allow 80/tcp
sudo ufw allow 8999/tcp
sudo ufw --force enable
echo "### Installing python-bitcoinrpc"
sudo pip install python-bitcoinrpc
echo "### Changing to paycoind directory"
cd ~
echo "### Starting Paycoin Server"
./paycoind
echo "### Changing to home directory"
cd ~
echo "### IN 30 SECONDS PLEASE WRITE DOWN YOUR RPCUSER AND RPCPASSWORD AND PRESS CTRL+X (WE WILL NEED THESE SOON)"
sleep 30
cd .paycoin
nano paycoin.conf
echo "### Changing to home directory"
cd ~
echo "### Downloading the Web Interface"
mkdir ~/WebInterface/
cd ~/WebInterface/
wget -O WebInterface.py https://raw.githubusercontent.com/mitchellcash/PaycoinAutoNode/master/WebInterface.py
echo "### IN 30 SECONDS CONFIGURE WEBINTERFACE.PY WITH RPC_USER, RPC_PASS, NODE_LOCATION, NODE_NAME, NODE_IP, DONATION_XPY_ADDR AND EXIT (DON’T FORGET TO SAVE)"
sleep 30
nano WebInterface.py
echo "### Installing the Web Interface"
sudo python WebInterface.py
echo "### Changing to home directory"
cd ~
echo "### Scheduling Cron Job to run WebInterface.py every 5 minutes"
(crontab -l ; echo "*/5 * * * * sudo python ~/WebInterface/WebInterface.py")| crontab -
echo "### System will now reboot"
reboot