#!/bin/bash

# define the IP address and hostname of the puppetmaster

PM_IP=34.213.66.6
PM_HOSTNAME=linuxmdm

# add the puppetmaster's hostname to DNS
# this is required for cert trust; can be deprecated when tradeshift.com DNS is updated

if grep -q "$PM_IP $PM_HOSTNAME.tradeshift.com $PM_HOSTNAME" /etc/hosts; then
	echo "the correct puppetmaster ($PM_HOSTNAME) IP is already in the hosts file, skipping..."
elif grep -q "$PM_HOSTNAME.tradeshift.com" /etc/hosts; then
	echo "adding puppetmaster ($PM_HOSTNAME) to the hosts file..."
	sed -i "/$PM_HOSTNAME.tradeshift.com/d" /etc/hosts
	sed -i "2i$PM_IP $PM_HOSTNAME.tradeshift.com $PM_HOSTNAME" /etc/hosts
else
	echo "adding puppetmaster ($PM_HOSTNAME) to the hosts file..."
	sed -i "2i$PM_IP $PM_HOSTNAME.tradeshift.com $PM_HOSTNAME" /etc/hosts
fi

# curl is needed to grab the join script, if it isn't already installed

if ! [ "$(command -v curl)" ]; then
	apt-get -y install curl
else
	echo "curl is already installed, skipping installation..."
fi

# download and run the join script

curl -k https://$PM_HOSTNAME.tradeshift.com:8140/packages/current/install.bash | bash
