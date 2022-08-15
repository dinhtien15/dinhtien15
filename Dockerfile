FROM nginx:latest

ADD /web/ /usr/share/nginx/html/
RUN ["rm", "-f", "/etc/localtime"]
RUN ["ln", "-s", "/usr/share/zoneinfo/Asia/Ho_Chi_Minh", "/etc/localtime"]
RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf

EXPOSE 80

#lenh khoi tao ban dau
yum install -y epel-release 
yum install -y htop iptop net-tools open-vm-tools nano telnet wget


#tang limit openfile

cat > /etc/security/limits.conf <<EOF
* soft nproc 65535
* hard nproc 65535

*         hard    nofile      500000
*         soft    nofile      500000
root      hard    nofile      500000
root      soft    nofile      500000

EOF

cat > /etc/sysctl.conf <<EOF
fs.inotify.max_user_watches = 1048576
fs.file-max = 500000
EOF

sysctl -p /etc/sysctl.conf
sysctl -w fs.file-max=100000
sysctl --system


yum install -y ntpdate
ntpdate vn.pool.ntp.org

firewall-cmd --zone=public --add-port=8100/tcp --permanent
firewall-cmd --reload

systemctl start firewalld
systemctl enable firewalld



cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"],"insecure-registries" : ["10.9.2.151:5000", "10.9.3.122:5000", "10.9.3.70:5000"]
}
EOF


