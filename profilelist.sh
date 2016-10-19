#!/bin/sh

# Author: Jason Beard
# Purpose: List the verbose names of OSX configuration profiles (i.e. from Casper)

# List the Profile Names with their Profile Identifiers.
CompLevelProfiles=`profiles -C -v | awk -F: '/attribute: name/{print $NF}''/attribute: profileIdentifier/{print $NF "\n"}' | sed 's/ //'`
echo "<result>\n$CompLevelProfiles\n</result>"
