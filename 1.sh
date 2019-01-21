#安装rTorrent
wget https://github.com/p1956/DFGDGDDHDHFDHDHDHD/raw/master/rTorrent0.9.7CentOS7install.sh && chmod +x rTorrentCentOS7install.sh
./rTorrentCentOS7install.sh

#安装SS（系统支持：CentOS，Debian，Ubuntu）
wget --no-check-certificate -O shadowsocks-go.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-go.sh
chmod +x shadowsocks-go.sh
./shadowsocks-go.sh 2>&1 | tee shadowsocks-go.log

#安装Pip： 
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
