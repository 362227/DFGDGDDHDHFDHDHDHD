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
