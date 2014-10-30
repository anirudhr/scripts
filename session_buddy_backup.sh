#!/bin/bash

BACKUPLOC=/media/blood/docs/sessionBuddyBackup/
DATE=`date +'%Y-%m-%d'`
cp -r /home/blood/.config/google-chrome/Default/databases/chrome-extension_edacconmaakjimmfgnblocblbcdcpbko_0 $BACKUPLOC/$DATE
