#!/bin/bash

# Tút RClone trên mac

# Khi tải/clone repo này về, lưu các file vào thư mục ~/rclone, 
# chạy câu lệnh cho nhanh (nếu mặc định tải về ở thư mục ~/Downloads):
# mkdir -p ~/rclone && cp ~/Downloads/com.paul.rclone.mount.plist ~/Downloads/mount.sh ~/rclone/

# Lưu ý: cần phải có macFUSE trước, tương đương với WINFSP bên win, 
# cài ở đây: https://github.com/macfuse/macfuse/wiki/Getting-Started

# Đọc hết tút xong mới thao tác

# Bước 1: Cài đặt rclone
# Dùng script trên trang chủ
# curl https://rclone.org/install.sh | sudo bash
# Hoặc qua Homebrew
# brew install rclone

# Bước 2: Cấu hình rclone
# rclone config
# chọn như bước 2 ở tút https://voz.ee/notes/view/cfeafbda-8e0e-46dc-a06d-b81ac0bc712f
# Thank bác Lớp Phó Học Tập https://www.facebook.com/groups/nghiengoogleviet/posts/2315355895564276/

# Bước 3: Xác thực tài khoản
# Nếu bước config chưa hiện lên option auto config để login trên web như tút, 
# chạy lệnh sau để lấy token:
# rclone authorize "drive"
# Mở trình duyệt chọn ok ok
# Sau khi đăng nhập xong, nó sẽ hiện lên 1 dòng token dạng:
# {"access_token":"CÁI.NÀY.QUAN.TRỌNG.ĐỪNG.ĐỂ.AI.BIẾT","token_type":"Bearer","refresh_token":"AI.LẤY.ĐƯỢC.TOKEN.LÀ.CÓ.THỂ.LẤY.ĐƯỢC.DRIVE.CỦA.MÌNH","expiry":"THẾ.NÊN.TRƯỚC.KHI.MỞ.RA.XEM.THÌ.NGÓ.XEM.SAU.LƯNG.CÓ.AI.KHÔNG"}
# copy nguyên đoạn token đó từ dấu { đến hết dấu } vào config
# File config thường nằm trong này: ~/.config/rclone/rclone.conf
# Nội dung trong file này kiểu:
# [tên-config-của-bạn-đặt-ở-bước-2]
# type = drive
# scope = drive
# token = {copy token vào đây}
# Lưu lại

# Bước 4: Mount
# Cấp quyền thực thi cho file này: chmod +x ~/rclone/mount.sh
# Chạy file: sh ~/rclone/mount.sh -c "tên-config-của-bạn-đặt-ở-bước-2" -d "đường-dẫn-đến-thư-mục-mount"

# Bước 5: Kiểm tra
# rclone config reconnect tên-config-của-bạn-đặt-ở-bước-2:
# Kiểm tra đã kết nối chưa, đã load được các file trên cloud chưa
# rclone ls tên-config-của-bạn-đặt-ở-bước-2

# Define default values
CONFIG_NAME="tên-config-của-bạn-đặt-ở-bước-2"
MOUNT_DIR="$HOME/PaulExampleGGDrive"

# Parse command line options
while getopts "c:d:" opt; do
  case $opt in
    c) CONFIG_NAME="$OPTARG" ;;
    d) MOUNT_DIR="$OPTARG" ;;
    *) echo "Usage: $0 [-c config_name] [-d mount_directory]" >&2; exit 1 ;;
  esac
done

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

# Sử dụng câu lệnh này 1 lần để tự start mount lần sau mỗi khi mở máy: 
cp -av ~/rclone/com.paul.rclone.mount.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.paul.rclone.mount.plist