#!/bin/bash

# Determine working directory
install_dir=`dirname $0`

#
# Installing Pulse Secure
#

# Specify location of the Pulse Secure disk image
TOOLS=$install_dir/"PulseSecure.dmg"
  
# Specify location of the Pulse Secure configuration file
VPN_CONFIG_FILE=$install_dir/"Default.pulsepreconfig"

# Specify a /tmp/pulsesecure.XXXX mountpoint for the disk image
TMPMOUNT=`/usr/bin/mktemp -d /tmp/pulsesecure.XXXX`
 
# Mount the latest Pulse Secure disk image to the /tmp/junospulse.XXXX mountpoint
hdiutil attach "$TOOLS" -mountpoint "$TMPMOUNT" -nobrowse -noverify -noautoopen

# Install Pulse Secure
/usr/sbin/installer -dumplog -verbose -pkg "$(/usr/bin/find $TMPMOUNT -maxdepth 1 \( -iname \*\.pkg -o -iname \*\.mpkg \))" -target "$3"

#
# Applying VPN configuration file
#

if [[ -d "$3/Applications/Pulse Secure.app" ]]; then
  echo "Pulse Secure VPN Client Installed"
	"$3/Applications/Pulse Secure.app/Contents/Plugins/JamUI/jamCommand" -importFile "$VPN_CONFIG_FILE"
	echo "VPN Configuration Installed"
else 
	echo "Pulse Client Not Installed"	
fi

#
# Clean-up
#

# Unmount the Pulse Secure disk image
/usr/bin/hdiutil detach "$TMPMOUNT"

# Remove the /tmp/pulsesecure.XXXX mountpoint
/bin/rm -rf "$TMPMOUNT"

exit 0