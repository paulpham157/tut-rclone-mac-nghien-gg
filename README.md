
# Tút RClone trên mac

- Khi tải/clone repo này về, lưu các file vào thư mục ~/rclone, 
- chạy câu lệnh cho nhanh (nếu mặc định tải về ở thư mục ~/Downloads):
```bash
mkdir -p ~/rclone && cp ~/Downloads/com.paul.rclone.mount.plist ~/Downloads/mount.sh ~/rclone/
```
- Lưu ý: cần phải có macFUSE trước, tương đương với WINFSP bên win, 
- cài ở đây: https://github.com/macfuse/macfuse/wiki/Getting-Started

## Đọc hết tút xong mới thao tác

### Bước 1: Cài đặt rclone
- Dùng script trên trang chủ
```bash
curl https://rclone.org/install.sh | sudo bash
```
- Hoặc qua Homebrew
```bash
brew install rclone
```

### Bước 2: Cấu hình rclone
```bash
rclone config
```
- chọn như bước 2 ở tút https://voz.ee/notes/view/cfeafbda-8e0e-46dc-a06d-b81ac0bc712f
- Thank bác Lớp Phó Học Tập https://www.facebook.com/groups/nghiengoogleviet/posts/2315355895564276/

### Bước 3: Xác thực tài khoản
- Nếu bước config chưa hiện lên option auto config để login trên web như tút, 
- chạy lệnh sau để lấy token:
```bash
rclone authorize "drive"
```
- Mở trình duyệt chọn ok ok
- Sau khi đăng nhập xong, nó sẽ hiện lên 1 dòng token dạng:
```bash
{"access_token":"CÁI.NÀY.QUAN.TRỌNG.ĐỪNG.ĐỂ.AI.BIẾT","token_type":"Bearer","refresh_token":"AI.LẤY.ĐƯỢC.TOKEN.LÀ.CÓ.THỂ.LẤY.ĐƯỢC.DRIVE.CỦA.MÌNH","expiry":"THẾ.NÊN.TRƯỚC.KHI.MỞ.RA.XEM.THÌ.NGÓ.XEM.SAU.LƯNG.CÓ.AI.KHÔNG"}
```
- copy nguyên đoạn token đó từ dấu { đến hết dấu } vào config
- File config thường nằm trong này: 
```bash
~/.config/rclone/rclone.conf
```
- Nội dung trong file này kiểu:
```bash
[tên-config-của-bạn-đặt-ở-bước-2]
type = drive
scope = drive
token = {copy token vào đây}
```
- Lưu lại

### Bước 4: Mount
- Cấp quyền thực thi cho file này: 
```bash
chmod +x ~/rclone/mount.sh
```
- Nhớ mở file ra và thay "tên-config-của-bạn-đặt-ở-bước-2" thành tên config đã làm ở bước 2
- Chạy file: 
```bash
sh ~/rclone/mount.sh -c "tên-config-của-bạn-đặt-ở-bước-2" -d "đường-dẫn-đến-thư-mục-mount"
```

### Bước 5: Kiểm tra
```bash
rclone config reconnect tên-config-của-bạn-đặt-ở-bước-2:
```
- Kiểm tra đã kết nối chưa, đã load được các file trên cloud chưa
- Nếu chưa kết nối, có thể cần kết nối lại
```bash
rclone ls tên-config-của-bạn-đặt-ở-bước-2:
```

# Góc khều donate (có thì có động lực hơn :v)
![qr_paul](qr_paul.jpg)

Hoặc

<a href="https://www.paypal.com/paypalme/hungpham2302" target="_blank"><img src="https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white" /></a>