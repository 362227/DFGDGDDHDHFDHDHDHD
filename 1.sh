mkdir /usr/share/nginx/html/download

wget https://github.com/p1956/DFGDGDDHDHFDHDHDHD/raw/master/default.conf -O "/etc/nginx/conf.d/default.conf"

service nginx restart












#安装SSR
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh
chmod +x shadowsocksR.sh
./shadowsocksR.sh 2>&1 | tee shadowsocksR.log

#SSR安装Pip： 
yum install python-pip 

#更新到最新：
pip install --upgrade pip

#安装killall：
yum install psmisc

#安装streamlink
pip install --upgrade streamlink

#安装环境：
yum install gcc gcc-c++ ncurses-devel perl 
yum -y install make gcc gcc-c++ ncurses-devel
yum -y install zlib zlib-devel 

#安装youtube-dl 
wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl 
