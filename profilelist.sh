#!/bin/sh

# List the Profile Names with their Profile Identifiers.
CompLevelProfiles=`profiles -C -v | awk -F: '/attribute: name/{print $NF}''/attribute: profileIdentifier/{print $NF "\n"}' | sed 's/ //'`
echo "<result>\n$CompLevelProfiles\n</result>"
