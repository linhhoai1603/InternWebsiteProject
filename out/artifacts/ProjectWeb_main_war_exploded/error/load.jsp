<%--
  Created by IntelliJ IDEA.
  User: mypc
  Date: 4/27/2025
  Time: 6:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
 Trên CentOS (gõ lệnh ở terminal VM hoặc dùng PuTTY sau này)
Bước 1: Cập nhật hệ thống
sudo dnf update -y
sudo dnf install -y epel-release

Bước 2: Cài đặt OpenSSH Server (nếu chưa có)
nano /etc/ssh/sshd_config : đổi PermitRootLogin thành yes
systemctl start sshd
systemctl status sshd
systemctl enable sshd
sudo dnf install -y openssh-server
sudo systemctl enable sshd --now

Bước 3: Tìm địa chỉ IP của máy ảo
ip a
Ghi lại IP để dùng trong PuTTY sau. truy cập putty

 4. CÀI JDK 21 TRÊN CENTOS
 sudo dnf install -y java-21-openjdk java-21-openjdk-devel
 Kiểm tra:
 java -version

 5. CÀI ĐẶT DOCKER
 sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
 sudo dnf install -y docker-ce docker-ce-cli containerd.io
 sudo systemctl enable docker --now
 sudo usermod -aG docker $USER
 → Thoát ra và đăng nhập lại để áp dụng nhóm Docker (gõ exit, đóng putty mở lại)
 Kiểm tra:
 docker version
docker login (username huy1801 pss anhhuy1801)
 6. CÀI ĐẶT VÀ CẤU HÌNH MYSQL 8.3.0 BẰNG DOCKER
 docker pull mysql:8.3
 Tạo container:
 docker run --name mysql8 -e MYSQL_ROOT_PASSWORD=centos -e MYSQL_DATABASE=project_web -p 3306:3306 -d mysql:8.3
 ⚠️ Mở port 3306 trên firewall:
 sudo firewall-cmd --permanent --add-port=3306/tcp
 sudo firewall-cmd --reload

 kết nối navicat

 •	Host: IP của máy ảo CentOS
 •	Port: 3306
 •	User: root
 •	Password: centos
 •	DB: project_web

 8. TRIỂN KHAI ỨNG DỤNG JAVA SERVLET VỚI TOMCAT (TRONG DOCKER)
 Bước 1: Tạo file Dockerfile (trên máy host hoặc SSH vào CentOS)
 Trong putty
 mkdir -p ~/java-web-docker
 cd ~/java-web-docker
 Dùng WinSCP để kéo file WAR vào thư mục ~/java-web-docker
 nano Dockerfile
 FROM tomcat:10.1-jdk21
 COPY /ProjectWeb.war /usr/local/tomcat/webapps/
 Bước 2: Build image và run container:
 docker build -t my-java-servlet .
 docker run -d -p 8080:8080 --name servlet-app my-java-servlet
 Mở port:
 sudo firewall-cmd --permanent --add-port=8080/tcp
 sudo firewall-cmd --reload

 9. TRUY CẬP WEBSITE TỪ WINDOWS
 Trên trình duyệt:
 http://IP_VM:8080/ProjectWeb/


nếu không kết nối được navicat
mysql -u root -p

 GRANT ALL PRIVILEGES ON . TO 'root'@'%' IDENTIFIED BY 'centos' WITH GRANT OPTION;
 FLUSH PRIVILEGES;

su vi /etc/mysql/my.cnf

[mysql]
bind-address = 0.0.0.0
nhan Esc va go :wq
systemctl restart mysql

</body>
</html>
