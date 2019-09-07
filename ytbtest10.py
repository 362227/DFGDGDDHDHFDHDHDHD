# -*- coding:utf-8 -*-
from bs4 import BeautifulSoup
import urllib2
import requests
import datetime
import time
import PyRSS2Gen
import sys
import re
reload(sys)
sys.setdefaultencoding('utf8')
class RssSpider():
    def __init__(self):
        self.myrss = PyRSS2Gen.RSS2(
            title='MyFeed',
            link='http://my.webserver.net',
            description=str(datetime.date.today()),
            pubDate=datetime.datetime.now(),
            lastBuildDate = datetime.datetime.now(),
            items=[]
            )
        self.xmlpath=r'/usr/share/nginx/kodexplorer/MyFeed1.xml'

        self.baseurl="https://www.youtube.com/feed/subscriptions?flow=2"

        self.homepage="https://www.youtube.com"
        self.proxies = {
            'http': 'http://127.0.0.1:8087',
            'https': 'http://127.0.0.1:8087'
        }
        self.cookies = {
            "LOGIN_INFO" : "AFmmF2swRQIhAJPGsor9NtKhUeObwZBpB0hRmLztAmb2VCRwnbwynOIPAiAaEspBwqvQOpzYq0E235he7lCSGwFwyZq6gXvk-T8lfw:QUQ3MjNmeFZJSGhFVjAtcjI4RDExY3Z4aGM3c2dpUV9xTE1LaUNYbkM5RmxBcVZvaktyNkdhYjFuSnZNVXBRNEVhX25EQkJPU3pCbDZ5eE1SMjF6V0I2WjZXcnBOR20tSHJPWmJJNXZ5UHN1dFFaS3hkUDU2bnVuX3ZnZHdoTlVkUFFIeFpnUHRqMnJmYk91OG54VVZXQ1VpZk0wc2lFZ1FGZFpsVEpGRTFlTGFyVHB2cW8yRXFn",
            "SSID" : "ARVUYoQRS4jgCnOSM",
            "PREF" : "cvdm=grid&gl=RU&hl=zh-CN&al=zh-CN&f5=30010&f3=8&f1=50000000",
            "APISID" : "pzgp73ur0ncYC5_J/AXc30is2ZtkrrT92N",
            "SID" : "dQeUixcwYgp0gLhHCtM-pPCkqFmqefZSEiGX5_JGd--IpXhBnhHNZiKxNWeNHxsqhA93bA.",
            "SAPISID" :"b3rc-b0aeLqIsiq8/A5lOZ81fbgz6IgtoL",
            "HSID" : "AuckWm5oDP-hZftQ7",
            "VISITOR_INFO1_LIVE" :"B3Yo-e7P-Os",
            "YSC" : "a9uVrHIIxVg",
            "_ga" : "GA1.2.306650520.1543678480",
            "s_gl" : "1d69aac621b2f9c0a25dade722d6e24bcwIAAABVUw==",
        }
    def request(self,url,cookies,proxies):
        s = requests.Session()
        s.headers.update({'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36'})
        s.headers.update({'Accept-Language':'en-US,en;q=0.8'})
        r = s.get(url,proxies=False, verify = False, cookies=cookies)
        return r.text
    def enterpage(self,url):
        rsp=self.request(url,self.cookies,self.proxies)
        f = open("index.html", "wb")
        f.write(rsp)
        soup=BeautifulSoup(rsp)
        div=soup.find('div',{'id':'content'})
        timespan=div.find('div',{'id':'watch-uploader-info'}).find('strong').get_text()
        ititle=soup.find('div',{'id':'watch-headline-title'}).find('span').get_text()
        description=soup.find('p',{'id':'eow-description'})
        rss=PyRSS2Gen.RSSItem(
        title=ititle,
        link=url,
        description = str(div),
        pubDate = timespan)
        return rss
    def getcontent(self,total):
        rsp=self.request(self.baseurl,self.cookies,self.proxies)
        soup=BeautifulSoup(rsp)
        ul=soup.find('div',{'id':'browse-items-primary'})
        count=0
        for li in ul.findAll('div',{'class':'yt-lockup-content'}):
            if count==total:
                print(count)
                break
            h3=li.find('h3')
            thumbnail = li.find_previous('div',{'class':'yt-lockup-thumbnail'})
            if h3 is not None:
                alink=h3.find('a')
                if alink is not None:
                    title=alink.get('title')
                    link=alink.get('href')
                    #img= thumbnail.find('span',{'class':'yt-thumb-simple'}).find('img')
            div=li.find('div',{'class':'yt-lockup-byline'})
            if div is not None:
                author=div.find('a')
                if author is not None:
                    fromwhere=author.get_text()
                else:
                    fromwhere=''
            div=li.find('div',{'class':'yt-lockup-description'})
            img1='<br><img src='+'https://i.ytimg.com/vi/'+link.split('=')[1]+'/hqdefault.jpg'+'><br>'
            img2='<a href='+'https://i.ytimg.com/vi/'+link.split('=')[1]+'/maxresdefault.jpg'+'>https://i.ytimg.com/vi/'+link.split('=')[1]+'/maxresdefault.jpg</a><br>'
            rss=PyRSS2Gen.RSSItem(title=title,link="https://www.youtube.com"+link,author=fromwhere,description=img1+img2,)
            print(title,link,fromwhere,img1+img2)
            self.myrss.items.append(rss)
            count+=1
    def SaveRssFile(self,filename):
        finallxml=self.myrss.to_xml(encoding='utf-8')
        file=open(self.xmlpath,'w')
        file.writelines(finallxml)
        file.close()
if __name__=='__main__':
    rssSpider=RssSpider()
    rssSpider.getcontent(90)
    rssSpider.SaveRssFile('myfeed1.xml')
