#!/usr/bin/env bash

NAME="flowdock-reboot"
ACTIVEWINDOWNAME="activeWindow.scpt"
PREFIX="/usr/local/bin"
REBOOT_PATH="$PREFIX/$NAME"
ACTIVEWINDOW_PATH="$PREFIX/$ACTIVEWINDOWNAME"
PLIST="org.jmutter.flowdock-reboot"
FULL_PLIST="$HOME/Library/LaunchAgents/$PLIST.plist"
INTERVAL=3600

sed "s:FLOWDOCK_REBOOT:$REBOOT_PATH:g" $PLIST.example > $PLIST.tmp && \
sed "s:INTERVAL:$INTERVAL:g" $PLIST.tmp > $PLIST.plist && \
rm $PLIST.tmp

cp $NAME $REBOOT_PATH
cp $ACTIVEWINDOWNAME $ACTIVEWINDOW_PATH

if [ `launchctl list | grep -c $PLIST` = "1" ]; then
	echo "already installed, removing old version"
	launchctl unload $FULL_PLIST
fi

mv $PLIST.plist $FULL_PLIST
launchctl load -F $FULL_PLIST
echo "Done!"

