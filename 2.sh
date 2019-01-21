#安装rTorrent
wget https://github.com/p1956/DFGDGDDHDHFDHDHDHD/raw/master/rTorrent0.9.7CentOS7install.sh && chmod +x rTorrentCentOS7install.sh
./rTorrentCentOS7install.sh

#安装SS（系统支持：CentOS，Debian，Ubuntu）
wget --no-check-certificate -O shadowsocks-go.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-go.sh
chmod +x shadowsocks-go.sh
./shadowsocks-go.sh 2>&1 | tee shadowsocks-go.log

#安装mediainfo
yum install mediainfo
curl https://yt-dl.org/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl
