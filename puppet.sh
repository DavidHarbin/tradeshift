#!/bin/bash

# define the IP address of the puppetmaster

PM_IP=34.214.79.56

# add the puppetmaster's hostname to DNS
# this is required for cert trust; can be deprecated when tradeshift.com DNS is updated

if grep -q "$PM_IP linuxmdm.tradeshift.com linuxmdm" /etc/hosts; then
	echo "the correct puppetmaster (linuxmdm) IP is already in the hosts file, skipping..."
elif grep -q "linuxmdm.tradeshift.com" /etc/hosts; then
	echo "adding puppetmaster (linuxmdm) to the hosts file..."
	sed -i '/linuxmdm.tradeshift.com/d' /etc/hosts
	sed -i "2i$PM_IP linuxmdm.tradeshift.com linuxmdm" /etc/hosts
else
	echo "adding puppetmaster (linuxmdm) to the hosts file..."
	sed -i "2i$PM_IP linuxmdm.tradeshift.com linuxmdm" /etc/hosts
fi

# curl is needed to grab the join script, if it isn't already installed

if ! [ "$(command -v curl)" ]; then
	apt-get -y install curl
else
	echo "curl is already installed, skipping installation..."
fi

# download and run the join script

curl -k https://linuxmdm.tradeshift.com:8140/packages/current/install.bash | bash
