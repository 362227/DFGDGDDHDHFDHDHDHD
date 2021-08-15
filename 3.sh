#安装v2ray
wget -N --no-check-certificate -q -O v2ray.sh "https://raw.githubusercontent.com/10362227/DFGDGDDHDHFDHDHDHD/master/v2ray.sh" && chmod +x v2ray.sh && bash v2ray.sh
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
* * * * * /usr/share/nginx/kodexplorer/a.sh
* * * * * sleep 30; /usr/share/nginx/kodexplorer/a.sh
0 3 * * * tar -zcvf /usr/share/nginx/kodexplorer/backup.tar.gz --exclude=config --exclude=plugins --exclude=static --exclude=data --exclude=app /usr/share/nginx/kodexplorer
0 4 * * * rclone move /usr/share/nginx/kodexplorer/backup.tar.gz 10362227:backup --exclude --local-no-check-updated
* * * * * chmod -R 777 /usr/share/nginx/kodexplorer/data/User/admin/home/
* * * * * chmod -R 777 /usr/share/nginx/html
* * * * * chmod -R 777 /usr/share/nginx/kodexplorer/
#0 3 * * * screen rclone sync /usr/share/nginx/kodexplorer/ 10362227:backup --exclude "/{config,plugins,static,data,app}/" --local-no-check-updated
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

#安装证书HTTPS
#先关闭80端口
lsof -i:80 | awk '{print $2}' | grep -v "PID" | xargs kill -9
curl https://get.acme.sh | sh
source ~/.bashrc
acme.sh --issue --standalone -d 362227.top
acme.sh --issue --standalone -d rsshub.362227.top
acme.sh --issue --standalone -d transmission.362227.top
acme.sh --issue --standalone -d ariang.362227.top





touch /etc/nginx/conf/conf.d/kodexplorer.conf
cat > /etc/nginx/conf/conf.d/kodexplorer.conf <<EOF
server {
   listen 443 ssl;
    server_name 362227.top;
 
    ssl on;
    ssl_certificate /root/.acme.sh/362227.top/fullchain.cer;
    ssl_certificate_key /root/.acme.sh362227.top/362227.top.key;
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

server {
    listen 80;
    listen [::]:80;
    server_name 362227.top;
 
    location / {
        return 301 https://$host$request_uri;
    }
}
EOF

touch /etc/nginx/conf/conf.d/ariang.conf
cat > /etc/nginx/conf/conf.d/ariang.conf <<EOF
server {
   listen 443 ssl;
    server_name ariang.362227.top;
 
    ssl on;
    ssl_certificate /root/.acme.sh/ariang.362227.top/fullchain.cer;
    ssl_certificate_key /root/.acme.sh/ariang.362227.top/ariang.362227.top.key;

    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;

    location / {
        root   /usr/share/nginx/ariang;
        index  index.html index.htm index.php;
    }
}

server {
    listen 80;
    listen [::]:80;
    server_name ariang.362227.top;
 
    location / {
        return 301 https://$host$request_uri;
    }
}
EOF
 
touch /etc/nginx/conf/conf.d/rsshub.conf
cat > /etc/nginx/conf/conf.d/rsshub.conf <<EOF
server {
   listen 443 ssl;
    server_name rsshub.362227.top;
 
    ssl on;
    ssl_certificate /root/.acme.sh/rsshub.362227.top/fullchain.cer;
    ssl_certificate_key /root/.acme.sh/rsshub.362227.top/rsshub.362227.top.key;
    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;
    location / {
        proxy_pass        http://localhost:1200;
    }

}

server {
    listen 80;
    listen [::]:80;
    server_name rsshub.362227.top;
 
    location / {
        return 301 https://$host$request_uri;
    }
}
EOF


touch /etc/nginx/conf/conf.d/transmission.conf
cat > /etc/nginx/conf/conf.d/transmission.conf <<EOF
server {
   listen 443 ssl;
    server_name transmission.362227.top;
 
    ssl on;
    ssl_certificate /root/.acme.sh/transmission.362227.top/fullchain.cer;
    ssl_certificate_key /root/.acme.sh/transmission.362227.top/transmission.362227.top.key;
    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;
    location / {
        proxy_pass        http://localhost:9091;
    }

}

server {
    listen 80;
    listen [::]:80;
    server_name transmission.362227.top;
 
    location / {
        return 301 https://$host$request_uri;
    }
}
EOF

mkdir /usr/share/nginx/kodexplorer/data/User/admin/home/hls
cat > /etc/nginx/conf/nginx.conf <<EOF

user  root;
worker_processes  3;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  4096;
}


rtmp {    
    server {    
        listen 1935;  #监听的端口  
        chunk_size 4000;    
           
        application hls {  #rtmp推流请求路径  
            live on;    
            hls on;    
            hls_path /usr/share/nginx/kodexplorer/data/User/admin/home/hls;    
            hls_fragment 5s; 
            hls_playlist_length 14660s;  #总共可以回看的事件，这里设置的是1分钟。   
        }    
    }    
}










http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    server {
        listen       80;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   /usr/share/nginx/kodexplorer/data/User/admin/home/hls;
            index  index.html index.htm;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/kodexplorer/data/User/admin/home/hls;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }


    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;

    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;

    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;

    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

include conf.d/*.conf;
}

EOF



#重启nginx
sudo systemctl restart nginx


#安装streamlink
pip install --upgrade streamlink
yum install python3-pip -y
pip3 install streamlink

#安装psmisc
yum -y install psmisc

sudo pip install requests
easy_install beautifulsoup4
pip install beautifulsoup4
easy_install PyRSS2Gen
pip install PyRSS2Gen
easy_install beautifulsoup
pip install beautifulsoup

#安装googledriver 
#wget https://raw.githubusercontent.com/circulosmeos/gdown.pl/master/gdown.pl
#chmod +x gdown.pl

chmod -R 777 /usr/share/nginx/kodexplorer/
chmod -R 777 /usr/share/nginx/


#安装rclone
yum install fuse -y
curl https://rclone.org/install.sh | sudo bash
rclone config


