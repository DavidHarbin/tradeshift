#!bin/bash

while (( $(date +%M) < 29 )) ; do sleep 1; done; sudo -H -u `ls -l /dev/console | awk '{print $3}'` bash -c 'open "http://tsociety.net/"'
