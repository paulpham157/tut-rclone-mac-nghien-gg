#!/bin/bash

launchctl unload ~/Library/LaunchAgents/com.paul.rclone.mount.plist
rm -f ~/Library/LaunchAgents/com.paul.rclone.mount.plist
sh ~/rclone/unmount.sh