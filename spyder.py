#!/usr/bin/env python

from html.parser import HTMLParser
from urllib.parse import urljoin

class LinkParser(HTMLParser):
    def __init__(self):
        self.anchorlist = []
        super().__init__()
    
    def handle_starttag(self, tag, attrs):
        if (tag != 'a'): return
        for a,v in attrs:
            if a == 'href': self.anchorlist.append(v)

def links(file):
    try:
        p = LinkParser(); p.feed(open(file).read()); p.close()
        return filter(lambda x: ':' not in x, p.anchorlist)
    except:
        return []

def crawl(file, visited):
    if file.endswith('/') or file.endswith('.'):
        file = urljoin(file, 'index.html')
    
    if file and file not in visited:
        visited.add(file)
        base = file[0:file.rfind('/')+1]
        
        for f in links(file):
            visited = crawl(urljoin(base, f), visited)
    
    return visited

site = list(crawl('html/', set())); site.sort()

for i in site: print(i)