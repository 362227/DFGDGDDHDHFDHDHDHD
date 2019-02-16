#1.安装transmission 
wget https://github.com/ronggang/transmission-web-control/raw/master/release/install-tr-control.sh
sudo bash install-tr-control.sh
##（注：如要更新新版，执行此命令即可）
##开机启动：
chkconfig transmission-daemon on

#2.安装RTMP
#a.使用yum安装git:
yum install git
#b.下载nginx-rtmp-module,官方github地址：https://github.com/arut/nginx-rtmp-module
git clone https://github.com/arut/nginx-rtmp-module.git
#c.yum安装openssl:
yum -y install openssl openssl-devel
#d.如果安装出现在下面的错误是缺少编译环境。安装编译源码所需的工具和库 （./configure: error: C compiler cc is not found ）
yum install gcc gcc-c++ ncurses-devel perl 
#e.
wget http://nginx.org/download/nginx-1.8.1.tar.gz  
tar -zxvf nginx-1.8.1.tar.gz  
cd nginx-1.8.1  
./configure --prefix=/usr/local/nginx  --add-module=../nginx-rtmp-module  --with-http_ssl_module    
make && make install 

#3.修改nginx配置文件
cat > /usr/local/nginx/conf/nginx.conf <<EOF
#user  nobody;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}

rtmp {    
    server {    
        listen 1935;  #监听的端口  
        chunk_size 4000;    
           
        application hls {  #rtmp推流请求路径  
            live on;    
            hls on;    
            hls_path /usr/share/nginx/html/hls;    
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
    keepalive_timeout  7200;

    #gzip  on;

server {  
    listen       81;  
    server_name  localhost;  
    #charset koi8-r;  
    #access_log  logs/host.access.log  main;  
  
    location / {  
        root   /usr/share/nginx/html;  
        index  index.html index.htm;  
    }  
  
    #error_page  404              /404.html;  
  
    # redirect server error pages to the static page /50x.html  
    #  
    error_page   500 502 503 504  /50x.html;  
    location = /50x.html {  
        root   html;  
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

}
EOF

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

#安装SSR（系统支持：CentOS，Debian，Ubuntu）
wget --no-check-certificate -O shadowsocks-go.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-go.sh
chmod +x shadowsocks-go.sh
./shadowsocks-go.sh 2>&1 | tee shadowsocks-go.log

#安装mediainfo
yum install mediainfo

#安装youtube-dl
curl https://yt-dl.org/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl

#一键安装apache
yum install httpd
#启动apche
service httpd start 
apachectl start
mkdir /usr/share/nginx/html/download
#设置开机启动/关闭
systemctl enable httpd.service


