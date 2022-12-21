yum install git -y
yum install wget -y
yum groupinstall "Development Tools" -y

#安装python3.8
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel
wget https://www.python.org/ftp/python/3.8.3/Python-3.8.3.tgz
tar -zxvf Python-3.8.3.tgz
mkdir /usr/local/python3
cd Python-3.8.3
./configure --prefix=/usr/local/python3
make && make install
ln -s /usr/local/python3/bin/python3.8 /usr/bin/python3.8
ln -s /usr/local/python3/bin/pip3.8 /usr/bin/pip3.8

pip3 install wheel

#安装streamlink
pip3.8 install --user --upgrade git+https://github.com/streamlink/streamlink.git
cp /root/.local/bin/streamlink /usr/local/bin

#安装gdown
pip3.8 install --user --upgrade git+https://github.com/wkentaro/gdown.git
cp /root/.local/bin/gdown /usr/local/bin

#安装spotdl
export SPOTIPY_CLIENT_ID='a145db3dcd564b9592dacf10649e4ed5'
export SPOTIPY_CLIENT_SECRET='389614e1ec874f17b8c99511c7baa2f6'
pip3.8 install --user --upgrade git+https://github.com/spotDL/spotify-downloader.git
cp /root/.local/bin/spotdl /usr/local/bin


#安装spotify-dl  可以下新西兰区歌曲
pip3.8 install --user --upgrade git+https://github.com/SathyaBhat/spotify-dl.git
cp /root/.local/bin/spotify_dl /usr/local/bin


#安装v2ray
wget -N --no-check-certificate -q -O install.sh "https://raw.githubusercontent.com/wulabing/V2Ray_ws-tls_bash_onekey/master/install.sh" && chmod +x install.sh && bash install.sh
#wget -N --no-check-certificate -q -O install.sh "https://raw.githubusercontent.com/wulabing/V2Ray_ws-tls_bash_onekey/master/install.sh" && chmod +x install.sh && bash install.sh
#旧方法 bash -c "$(curl -fsSL https://raw.githubusercontent.com/p1956/DFGDGDDHDHFDHDHDHD/master/V2ray.fun.sh)"


#安装KOD
wget https://raw.githubusercontent.com/10362227/DFGDGDDHDHFDHDHDHD/master/Aria2%2BAriaNG%2BKodExplorer_Install.sh
#wget https://raw.githubusercontent.com/p1956/DFGDGDDHDHFDHDHDHD/master/Aria2%2BAriaNG%2BKodExplorer_Install.sh
chmod +x Aria2+AriaNG+KodExplorer_Install.sh
./Aria2+AriaNG+KodExplorer_Install.sh


#安装yarn
curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum install nodejs -y
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
sudo yum install yarn -y

#安装git
yum install git -y

#安装7z
yum install -y p7zip p7zip-plugins

#安装rar和unrar方法
wget https://www.rarlab.com/rar/rarlinux-x64-5.9.1.tar.gz --no-check-certificat
tar -zxvf rarlinux-x64-5.9.1.tar.gz
cd rar
cp -v rar unrar /usr/local/bin/
cd

#安装python3.6
#wget --no-check-certificate https://raw.githubusercontent.com/LunacyZeus/Python3.6-for-Centos7.0/master/install.sh && sh install.sh

#安装RSSHub
git clone https://github.com/10362227/RSSHub.git
cd RSSHub
yarn install --production
#screen  yarn start

cd /var/spool/cron
touch hello.sh
cat > /var/spool/cron/hello.sh <<EOF
chmod -R 777 /usr/share/nginx/kodexplorer/data/User/admin/home/
EOF
cat > /var/spool/cron/root <<EOF
46 0 * * * "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" > /dev/null
0 0 1 */2 * lsof -i:80 | awk '{print $2}' | grep -v "PID" | xargs kill -9 && acme.sh --issue --standalone --force --renew  -m 362227@163.com -d 362227.top && systemctl restart nginx
* * * * * /usr/share/nginx/kodexplorer/a.sh
* * * * * sleep 30; /usr/share/nginx/kodexplorer/a.sh
*/20 * * * * /usr/share/nginx/kodexplorer/b.sh
0 2 * * * cd /usr/share/nginx/kodexplorer/rss/huginn/ && php huginn备份.php
0 3 * * * tar -zcvf /usr/share/nginx/kodexplorer/backup.tar.gz --exclude=remote  --exclude=igvid  --exclude=config --exclude=plugins --exclude=static --exclude=data --exclude=app --exclude=aria2c --exclude=backup.tar.gz --exclude=*.mp4  --exclude=*.mov --exclude=*.mkv --exclude=*.webm --exclude=*.ts --exclude=*.m2ts --exclude=*.vob --exclude=*.mpg --exclude=*.avi --exclude=*.MP4  --exclude=*.MOV --exclude=*.MKV --exclude=*.WEBM --exclude=*.TS --exclude=*.M2TS --exclude=*.VOB --exclude=*.MPG --exclude=*.AVI   /usr/share/nginx/kodexplorer
0 4 * * * rclone copy /usr/share/nginx/kodexplorer/backup.tar.gz 10362227:backup --exclude --local-no-check-updated --config=/usr/share/nginx/kodexplorer/rclone.conf
0 5 * * * rclone move /usr/share/nginx/kodexplorer/igvid/ ysf2020:vimeo --transfers=1 -P --stats-one-line --contimeout 5h --max-depth 1 --size-only --include "*.{mp4,flv}"  --min-age 600m -P
0 7 * * *  find / -name "*.log" | xargs rm -rf
* * * * * /usr/share/nginx/kodexplorer/autostartrsshub.sh
*/49  * * * * 暂停/usr/share/nginx/kodexplorer/rss/ig.php
*/3 * * * *  python3.8 /usr/share/nginx/kodexplorer/selenium/uc.py
*/44 * * * * 暂停 curl -L http://362227.top/rss/FlareSolverrIG.php >  /usr/share/nginx/kodexplorer/flaresolverr/IG.html
* * * * * php /usr/share/nginx/kodexplorer/rss/ytb.php > /usr/share/nginx/kodexplorer/rss/ytb.xml


#
EOF



#1.安装transmission 
wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/91yuncode/master/transmission-centos.sh && bash transmission-centos.sh
wget https://github.com/ronggang/transmission-web-control/raw/master/release/install-tr-control-cn.sh --no-check-certificate && bash install-tr-control-cn.sh
##（注：如要更新新版，执行此命令即可）
##开机启动：
chkconfig transmission-daemon on

#修改密码transmission
##停止
systemctl stop transmission-daemon


cat > /var/lib/transmission/.config/transmission-daemon/settings.json <<EOF
{
    "alt-speed-down": 50,
    "alt-speed-enabled": false,
    "alt-speed-time-begin": 540,
    "alt-speed-time-day": 127,
    "alt-speed-time-enabled": false,
    "alt-speed-time-end": 1020,
    "alt-speed-up": 50,
    "bind-address-ipv4": "0.0.0.0",
    "bind-address-ipv6": "::",
    "blocklist-enabled": false,
    "blocklist-url": "http://www.example.com/blocklist",
    "cache-size-mb": 4,
    "dht-enabled": true,
    "download-dir": "/usr/share/nginx/kodexplorer/data/User/admin/home/",
    "download-queue-enabled": true,
    "download-queue-size": 5,
    "encryption": 1,
    "idle-seeding-limit": 500,
    "idle-seeding-limit-enabled": false,
    "incomplete-dir": "/var/lib/transmission/Downloads",
    "incomplete-dir-enabled": false,
    "lpd-enabled": false,
    "message-level": 1,
    "peer-congestion-algorithm": "",
    "peer-id-ttl-hours": 6,
    "peer-limit-global": 2000,
    "peer-limit-per-torrent": 2000,
    "peer-port": 51413,
    "peer-port-random-high": 65535,
    "peer-port-random-low": 49152,
    "peer-port-random-on-start": false,
    "peer-socket-tos": "default",
    "pex-enabled": true,
    "port-forwarding-enabled": true,
    "preallocation": 1,
    "prefetch-enabled": true,
    "queue-stalled-enabled": true,
    "queue-stalled-minutes": 30,
    "ratio-limit": 2,
    "ratio-limit-enabled": false,
    "rename-partial-files": true,
    "rpc-authentication-required": true,
    "rpc-bind-address": "0.0.0.0",
    "rpc-enabled": true,
    "rpc-host-whitelist": "",
    "rpc-host-whitelist-enabled": true,
    "rpc-password": "y362227",
    "rpc-port": 9091,
    "rpc-url": "/transmission/",
    "rpc-username": "",
    "rpc-whitelist": "127.0.0.1",
    "rpc-whitelist-enabled": false,
    "scrape-paused-torrents-enabled": true,
    "script-torrent-done-enabled": false,
    "script-torrent-done-filename": "",
    "seed-queue-enabled": false,
    "seed-queue-size": 10,
    "speed-limit-down": 100,
    "speed-limit-down-enabled": false,
    "speed-limit-up": 100,
    "speed-limit-up-enabled": false,
    "start-added-torrents": true,
    "trash-original-torrent-files": false,
    "umask": 18,
    "upload-slots-per-torrent": 14,
    "utp-enabled": true
}
EOF
systemctl stop transmission-daemon
systemctl start transmission-daemon


# 安装FFMPEG
yum install yasm -y
cd ~
wget http://www.ffmpeg.org/releases/ffmpeg-4.1.tar.gz
tar -xvf ffmpeg-4.1.tar.gz
cd ffmpeg-4.1
./configure --enable-libmp3lame && make && make install


#安装mediainfo
yum -y install mediainfo

#安装youtube-dl
wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl 


#安装youtube-dl
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
chmod a+rx /usr/local/bin/yt-dlp

#安装SSR
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh && chmod +x shadowsocksR.sh && ./shadowsocksR.sh 2>&1 | tee shadowsocksR.log

#安装Pip： 
#yum -y install python-pip 

iptables -F
iptables -F -t nat
iptables -X
iptables -X -t nat

#安装dos2unix： 
yum install -y dos2unix
#dos2unix proxychains

#安装证书HTTPS
#先关闭80端口
lsof -i:80 | awk '{print $2}' | grep -v "PID" | xargs kill -9
yum install lsof -y
yum install install socat -y
curl https://get.acme.sh | sh
source ~/.bashrc
#acme.sh --issue --standalone -m 362227@163.com -d 362227.top
#acme.sh --issue --standalone -m 362227@163.com -d rsshub.362227.top
#acme.sh --issue --standalone -m 362227@163.com -d transmission.362227.top
#acme.sh --issue --standalone -m 362227@163.com -d ariang.362227.top

#重新生成证书覆盖v2ray （换主机用，记得先修改DNS）
#rm -rf /root/.acme.sh/a.362227.top_ecc
#rename /root/.acme.sh/a.362227.top mv /root/.acme.sh/a.362227.top_ecc






mkdir /usr/share/nginx/kodexplorer/data/User/admin/home/hls

/etc/nginx/conf/nginx.conf


#重启nginx
sudo systemctl restart nginx



#安装psmisc
yum -y install psmisc

sudo pip install requests
easy_install beautifulsoup4
pip install beautifulsoup4
easy_install PyRSS2Gen
pip install PyRSS2Gen
easy_install beautifulsoup
pip install beautifulsoup

#安装proxychains
git clone https://github.com/rofl0r/proxychains-ng.git
cd proxychains-ng
./configure --prefix=/usr --sysconfdir=/etc
make && make install
make install-config
cd .. && rm -rf proxychains-ng
#vim /etc/proxychains.conf  //修改配置文件
#socks5  127.0.0.1 1080  //ip和port改成自己的ip和端口
#proxychains4 wget http://xxx.com/xxx.zip  


#安装googledriver 
pip3 install --upgrade --no-cache-dir gdown

chmod -R 777 /usr/share/nginx/kodexplorer/
chmod -R 777 /usr/share/nginx/

#0.安装goflyway
wget -N --no-check-certificate https://github.com/p1956/DFGDGDDHDHFDHDHDHD/raw/master/goflyway.sh && chmod +x goflyway.sh && bash goflyway.sh
#http://kernel.ubuntu.com/~kernel-ppa/mainline/

#安装rclone
yum install fuse -y
curl https://rclone.org/install.sh | sudo bash
rclone config


touch /etc/nginx/conf/conf.d/kodexplorer.conf
#cat > /etc/nginx/conf/conf.d/kodexplorer.conf <<EOF
server {
    listen       80;
    server_name  362227.top;
    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;
    location / {
        root   /usr/share/nginx/kodexplorer;
        index  index.html index.htm index.php;
    }
    location ~ \.php$ {
        root           /usr/share/nginx/kodexplorer;
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  /usr/share/nginx/kodexplorer$fastcgi_script_name;
        include        fastcgi_params;
    }
}
EOF

touch /etc/nginx/conf/conf.d/ariang.conf
#cat > /etc/nginx/conf/conf.d/ariang.conf <<EOF
server {
    listen       80;
    server_name  ariang.362227.top;
    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;
    location / {
        root   /usr/share/nginx/ariang;
        index  index.html index.htm index.php;
    }
}
EOF
 
touch /etc/nginx/conf/conf.d/rsshub.conf
#cat > /etc/nginx/conf/conf.d/rsshub.conf <<EOF
server {
    listen       80;
    server_name  rsshub.362227.top;
    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;
    location / {
        proxy_pass        http://localhost:1200;
    }
}
EOF


touch /etc/nginx/conf/conf.d/transmission.conf
#cat > /etc/nginx/conf/conf.d/transmission.conf <<EOF
server {
    listen       80;
    server_name  transmission.362227.top;
    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;
    location / {
        proxy_pass        http://localhost:9091;
    }
}
EOF
