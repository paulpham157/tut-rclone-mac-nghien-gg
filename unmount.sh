#!/bin/bash

# Find all rclone processes and kill them
pkill -f rclone || echo "No rclone processes found to kill"

# Alternatively, for more verbose output:
# ps aux | grep rclone | grep -v grep | awk '{print $2}' | xargs -r kill
