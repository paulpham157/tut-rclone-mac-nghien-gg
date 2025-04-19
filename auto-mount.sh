#!/bin/bash

# Sử dụng câu lệnh này 1 lần để tự start mount lần sau mỗi khi mở máy: 
cp -av ~/rclone/com.paul.rclone.mount.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.paul.rclone.mount.plist
