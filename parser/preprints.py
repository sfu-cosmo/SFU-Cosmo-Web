#!/usr/bin/env python
# -*- coding: utf-8 -*-

import io, re, operator

members = open('members.txt').read().splitlines()
anyofus = r'((\w+\.[~\-\s]+)*(' + ('|'.join(members)) + r'))'

class preprint:
    pass

class src(io.FileIO):
    def skip(self):
        for l in self:
            if l.strip(): break
        return l.rstrip().decode(encoding='UTF-8')

def parse(fp):
    while True:
        try:
            p = preprint()
            
            p.id, p.arxiv = re.match('(.*)\s+\[(.*)\]', fp.skip()).groups()
            p.year = re.match('\w+-(\d+)-\d+', p.id).group(1)
            
            p.authors = fp.skip()
            p.authors = re.sub(anyofus, r'<B>\1</B>', p.authors)
            p.authors = p.authors.replace('~', '&nbsp;')
            
            p.title = fp.skip().strip('"')
            
            yield p
        except: break

all = list(parse(src('preprints.txt')))
all.sort(key=operator.attrgetter('id'))
all.reverse()
