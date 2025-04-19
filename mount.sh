#!/bin/bash

# Sử dụng một tham số vị trí cho tên cấu hình; thư mục mount sẽ tự tạo trong $HOME
if [ $# -ne 1 ]; then
  echo "Lỗi: thiếu tên cấu hình rclone."
  echo "Cách dùng: $0 <tên-config>"
  echo "Ví dụ: $0 paul"
  exit 1
fi

CONFIG_NAME="$1"
MOUNT_DIR="$HOME/$CONFIG_NAME"

# Kiểm tra remote tồn tại
if ! rclone listremotes | grep -Fxq "${CONFIG_NAME}:"; then
  echo "Lỗi: config '$CONFIG_NAME' không tồn tại."
  echo "Chạy 'rclone config' để tạo cấu hình trước, sau đó mới gắn vào ổ đĩa."
  exit 1
fi

# Create necessary directories
mkdir -p "$MOUNT_DIR"
mkdir -p ~/rclone/caches
mkdir -p ~/rclone/logs

# Mount with specified options
rclone mount "$CONFIG_NAME": "$MOUNT_DIR" \
  --vfs-cache-mode full \
  --cache-dir ~/rclone/caches \
  --vfs-cache-max-size 20G \
  --vfs-cache-max-age 24h \
  --log-level INFO \
  --daemon
