wget https://raw.githubusercontent.com/p1956/DFGDGDDHDHFDHDHDHD/master/Aria2%2BAriaNG%2BKodExplorer_Install.sh
chmod +x Aria2+AriaNG+KodExplorer_Install.sh
./Aria2+AriaNG+KodExplorer_Install.sh
chmod -R 777 /usr/share/nginx/kodexplorer/data/User/admin/home/
chmod -R 777 /usr/share/nginx/html

cat > /etc/nginx/conf.d/default.conf <<EOF
server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        # 这里改动了，也可以写你的域名
        server_name  192.168.17.26;
        
        # 默认网站根目录（www目录）
        root         /usr/share/nginx/html;
        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
            # 这里改动了 定义首页索引文件的名称
            index index.php index.html index.htm;
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }

        # 这里新加的
        # PHP 脚本请求全部转发到 FastCGI处理. 使用FastCGI协议默认配置.
        # Fastcgi服务器和程序(PHP,Python)沟通的协议.
        location ~ \.php$ {
            # 设置监听端口
            fastcgi_pass   127.0.0.1:9000;
            # 设置nginx的默认首页文件(上面已经设置过了，可以删除)
            fastcgi_index  index.php;
            # 设置脚本文件请求的路径
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            # 引入fastcgi的配置文件
            include        fastcgi_params;
        }
    }
EOF

cd /var/spool/cron
touch hello.sh
cat > /var/spool/cron/hello.sh <<EOF
chmod -R 777 /usr/share/nginx/kodexplorer/data/User/admin/home/
EOF
cat > /var/spool/cron/root <<EOF
46 0 * * * "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" > /dev/null
*/2 * * * * /var/spool/cron/hello.sh
EOF

#0.安装goflyway
wget -N --no-check-certificate https://github.com/p1956/DFGDGDDHDHFDHDHDHD/raw/master/goflyway.sh && chmod +x goflyway.sh && bash goflyway.sh

#1.安装transmission 
wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/91yuncode/master/transmission-centos.sh && bash transmission-centos.sh
wget https://github.com/ronggang/transmission-web-control/raw/master/release/install-tr-control-cn.sh --no-check-certificate && bash install-tr-control-cn.sh
##（注：如要更新新版，执行此命令即可）
##开机启动：
chkconfig transmission-daemon on

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
    "download-dir": "/var/lib/transmission/Downloads",
    "download-queue-enabled": true,
    "download-queue-size": 5,
    "encryption": 1,
    "idle-seeding-limit": 30,
    "idle-seeding-limit-enabled": false,
    "incomplete-dir": "/var/lib/transmission/Downloads",
    "incomplete-dir-enabled": false,
    "lpd-enabled": false,
    "message-level": 1,
    "peer-congestion-algorithm": "",
    "peer-id-ttl-hours": 6,
    "peer-limit-global": 200,
    "peer-limit-per-torrent": 50,
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
    "rpc-password": "{46d97d59176b56259025012772d5d4ad36d03892saLCczwE",
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


# 安装FFMPEG
cd ~
wget --no-check-certificate https://www.johnvansickle.com/ffmpeg/old-releases/ffmpeg-4.0.3-64bit-static.tar.xz
tar -xJf ffmpeg-4.0.3-64bit-static.tar.xz
cd ffmpeg-4.0.3-64bit-static
cp ffmpeg /usr/bin/ffmpeg
cd ~
ffmpeg -version
if [ $? -eq 0 ];then
    echo -e "${green} FFMPEG安装成功 ${font}"
else 
    echo -e "${red} FFMPEG安装失败 ${font}"
    exit 1
fi


#安装mediainfo
yum -y install mediainfo

#安装youtube-dl
wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl 

#安装SSR
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh
chmod +x shadowsocksR.sh
./shadowsocksR.sh 2>&1 | tee shadowsocksR.log

#安装Pip： 
yum -y install python-pip 

iptables -F
iptables -F -t nat
iptables -X
iptables -X -t nat

#安装v2ray
bash -c "$(curl -fsSL https://raw.githubusercontent.com/p1956/DFGDGDDHDHFDHDHDHD/master/V2ray.fun.sh)"

#安装streamlink
pip install --upgrade streamlink

#安装psmisc
yum -y install psmisc
