# coding: utf-8
with open('../szse.txt', 'r') as f:
    code = f.readlines()
    
len(code)
code[-1]
print code[-1]
cs = code
code = cs[0]
code.splitlines()
code
code.splitlines()
code.splitlines()[0]
code.split(',')
code.split(',')[0]
ds = [ int(code.split(',')[0] for code in cs ]

;
]
ds = [ int(code.split(',')[0]) for code in cs ]
ds[0]
help(map)
help(filter)
filter(lambda x: x < 2000, ds)
d1 = filter(lambda x: x < 2000, ds)
d2 = filter(lambda x: x >= 2000 && x < 300000, ds)
d2 = filter(lambda x: x >= 2000 and x < 300000, ds)
d2
len(d2)
len(d1)
d3 = filter(lambda x: x >= 300000, ds)
len(d3)
d3
max(d1)
max(d1[:-3])
max(d2)
max(d3)
min(d1)
min(d3)
min(d2)
d = [ d1, d2, d3 ]
[ max(i) for i in d ]
d1.pop()
d1.pop()
d1.pop()
d1[-1]
[ max(i) for i in d ]
[ len(i) for i in d ]
import os.path
os.path.walk('history')
import os
os.listdir('history')
h = os.listdir('history')
len(h)
with open('history/000001.csv', 'r') as f:
lines = f.readlines()
with open('history/000001.csv', 'r') as f:
    lines = f.readlines()
lines
print lines[-1]
print lines[-1].split(',')
print lines[-1].split(',')[9]
9.4*0.5319
tuple( lines[-1].split(','))
tuple( lines[-1].split(','))[0]
tuple( lines[-1].split(','))[1]
tuple( lines[-1].split(','))[2]
r = [ line.split(',')[9] for line in lines ]
len(r)
filter(lambda x: x == 'None', r)
len(filter(lambda x: x == 'None', r))
help(reduce)
len(filter(lambda x: x == 'none', r))
r = filter(lambda x: x != 'None', r)
len(r)
r[-1]
r1 = [1.0]
for i in r:
r1.append(r1[-1]*(1+float(i)/100))
for i in r:
    r1.append(r1[-1]*(1+float(i)/100))
len(r1)
r1[-1]
max(r1)
r1[0]
min(r1)
r[-1]
r = [float(i) for i in r]
r[-1]
max(r)
min(r)
rc = list(r)
rc = sorted(rc)
rc[:10]
rc[:20]
rc[:30]
rc[-30:]
r[:30]
r[:50]
r[:100]
max(r[:100])
max(r[:1000])
max(r[:1500])
p
r1[:10]
r1[:100]
[ 1+i/100 for i in r ][:30]
for j in [ 1+i/100 for i in r ]:
	pass
r2 = [1.0]
for j in [ 1+i/100 for i in r ]:
    pass
for j in [ 1+i/100 for i in r ]:
    r2.append(r2[-1]*j)
max(r2)
zip(r, r2)[:30]
0.985017*(1+0.5297/100)
p = [1+i/100 for i in r]
p[30]
help(zip)
zip(r, p, r2)[:30]
1.0*0.985017
1.0*0.985017*0.99503
1.0*0.985017*0.99503*1.005297
zip(r, p, r2)[:50]
l
def getPrice(code):
	with open('history/'+code, 'r') as f:
		p = f.readlines()
	p = [ i.split(',')[9] for i in p ]
	p = filter(lambda x: x != 'None', p)
	p = [ float(i) for i in p ]
	r = [1.0]
	for i in p:
		r.append(r[-1]*(1+i/100))
len(getPrice('000001'))
def getPrice(code):
	with open('history/'+code, 'r') as f:
		p = f.readlines()
	p = [ i.split(',')[9] for i in p ]
	p = filter(lambda x: x != 'None', p)
	p = [ float(i) for i in p ]
	r = [1.0]
	for i in p:
		r.append(r[-1]*(1+i/100))
	return r
def getPrice(code):
	with open('history/'+code, 'r') as f:
		p = f.readlines()
	p = [ i.split(',')[9] for i in p ]
	p = filter(lambda x: x != 'None', p)
	p = [ float(i) for i in p ]
	r = [1.0]
	for i in p:
		r.append(r[-1]*(1+i/100))
	return r
len(getPrice('000001.csv'))
getPrice('000001.csv')[-1]
getPrice('000009.csv')[-1]
os.listdir('history')
def getPrice(code):
	with open('history/'+code, 'r') as f:
		p = f.readlines()
	last = p[-1]p = [ i.split(',')[9] for i in p ]
	p = filter(lambda x: x != 'None', p)
	p = [ float(i) for i in p ]
	r = [1.0]
	for i in p:
		r.append(r[-1]*(1+i/100))
	return r
def getPrice(code):
	with open('history/'+code, 'r') as f:
		p = f.readlines()
	last = p[-1]p = [ i.split(',')[9] for i in p ]
	p = filter(lambda x: x != 'None', p)
	p = [ float(i) for i in p ]
	r = [1.0]
	for i in p:
		r.append(r[-1]*(1+i/100))
	return r
def getPrice(code):
	with open('history/'+code, 'r') as f:
		p = f.readlines()
	last = p[-1]p = [ i.split(',')[9] for i in p ]
	p = filter(lambda x: x != 'None', p)
	p = [ float(i) for i in p ]
	r = [1.0]
	for i in p:
		r.append(r[-1]*(1+i/100))
	return r
def getPrice(code):
        with open('history/'+code, 'r') as f:
                p = f.readlines()
        last = p[-1].split(',')
		p = [ i.split(',')[9] for i in p ]
        p = filter(lambda x: x != 'None', p)
        p = [ float(i) for i in p ]
        r = [1.0]
        for i in p:
                r.append(r[-1]*(1+i/100))
        return (last[1], last[2], r)
def getPrice(code):
        with open('history/'+code, 'r') as f:
                p = f.readlines()
        last = p[-1].split(',')
		p = [ i.split(',')[9] for i in p ]
        p = filter(lambda x: x != 'None', p)
        p = [ float(i) for i in p ]
        r = [1.0]
        for i in p:
                r.append(r[-1]*(1+i/100))
        return (last[1], last[2], r)
def getPrice(code):
        with open('history/'+code, 'r') as f:
                p = f.readlines()
        last = p[-1].split(',')
		p = [ i.split(',')[9] for i in p ]
        p = filter(lambda x: x != 'None', p)
        p = [ float(i) for i in p ]
        r = [1.0]
        for i in p:
                r.append(r[-1]*(1+i/100))
        return (last[1], last[2], r)
def getPrice(code):
        with open('history/'+code, 'r') as f:
                p = f.readlines()
        last = p[-1].split(',')
		p = [ i.split(',')[9] for i in p ]
        p = filter(lambda x: x != 'None', p)
        p = [ float(i) for i in p ]
        r = [1.0]
        for i in p:
                r.append(r[-1]*(1+i/100))
        return (last[1], last[2], r)
def getPrice(code):
        with open('history/'+code, 'r') as f:
                p = f.readlines()
        last = p[-1].split(',')
        p = [ i.split(',')[9] for i in p ]
        p = filter(lambda x: x != 'None', p)
        p = [ float(i) for i in p ]
        r = [1.0]
        for i in p:
                r.append(r[-1]*(1+i/100))
        return (last[1], last[2], r)
getPrice('000009.csv')[-1]
getPrice('000009.csv')[-1][-1]
getPrice('000009.csv')[0]
getPrice('000009.csv')[1]
print getPrice('000009.csv')[1]
code
cs
n = os.listdir('history')
n
pp = [getPrice(i) for i in n]
def getPrice(code):
        with open('history/'+code, 'r') as f:
                p = f.readlines()
        if not p:
            return None
        last = p[-1].split(',')
p = [ i.split(',')[9] for i in p ]
p = filter(lambda x: x != 'None', p)
p = [ float(i) for i in p ]
r = [1.0]
for i in p:
        r.append(r[-1]*(1+i/100))
return (last[1], last[2], r)
def getPrice(code):
        with open('history/'+code, 'r') as f:
                p = f.readlines()
        if not p:
            return None
        last = p[-1].split(',')
p = [ i.split(',')[9] for i in p ]
p = filter(lambda x: x != 'None', p)
p = [ float(i) for i in p ]
r = [1.0]
for i in p:
        r.append(r[-1]*(1+i/100))
return (last[1], last[2], r)
def getPrice(code):
        with open('history/'+code, 'r') as f:
                p = f.readlines()
        if not p:
            return None
        last = p[-1].split(',')
        p = [ i.split(',')[9] for i in p ]
        p = filter(lambda x: x != 'None', p)
        p = [ float(i) for i in p ]
        r = [1.0]
        for i in p:
                r.append(r[-1]*(1+i/100))
        return (last[1], last[2], r)
pp = [getPrice(i) for i in n]
len(pp)
len(filter(lamda x: x is None, pp))
len(filter(lambda x: x is None, pp))
pp = filter(lambda x: x is not None, pp)
len(pp)
pp[0][0]
pp[0][1]
print pp[0][1]
p = [ (i[0], i[1], max(i[2])) for i in pp ]
p[0]
p = [ (i[0], i[1], (i[2][-1])) for i in pp ]
p[0]
help(sorted)
help(sorted)
sp = sorted(p, lambda x, y: x[2] < y[2])
sp[:10]
print sp[:10]
for s in sp[:10]:
	print s[0], s[1], s[2]
cmp(1, 2)
sp = sorted(p, lambda x, y: cmp(x[2],y[2]))
for s in sp[:10]:
	print s[0], s[1], s[2]
for s in sp[:10]:
	print '%s\t%s\t%s' % (s[0], s[1], s[2])
for s in sp[:10]:
	print '%10s%10s%10s' % (s[0], s[1], s[2])
for s in sp[:10]:
	print '%010s%010s%010s' % (s[0], s[1], s[2])
for s in sp[:10]:
	print '%20s%20s%20s' % (s[0], s[1], s[2])
for s in sp[:10]:
	print '%20s%20s%30s' % (s[0], s[1], s[2])
a = ''
a.strip()
a = '  a  '
a.strip()
for s in sp[:10]:
	print '%20s%20s%30s' % (s[0], s[1].strip(), s[2])
for s in sp[:10]:
	print '%20s%20s%20s' % (s[0], s[1].strip(), s[2])
for s in sp[:10]:
	print '%20s%s%20s' % (s[0], s[1].strip(), s[2])
for s in sp[:10]:
	print '%20s%-20s%20s' % (s[0], s[1].strip(), s[2])
for s in sp[:10]:
	print '%20s%20s%20s' % (s[0], s[1].strip(), s[2])
for s in sp[-10:]:
	print '%20s%20s%20s' % (s[0], s[1].strip(), s[2])
for s in sp[-30:]:
	print '%20s%20s%20s' % (s[0], s[1].strip(), s[2])
p = [ (i[0], i[1], max(i[2])) for i in pp ]
sp = sorted(p, lambda x, y: cmp(x[2],y[2]))
for s in sp[-30:]:
	print '%20s%20s%20s' % (s[0], s[1].strip(), s[2])
for s in sp[-50:]:
	print '%20s%20s%20s' % (s[0], s[1].strip(), s[2])
p = [ (i[0], i[1], max(i[2])/min(i[2])) for i in pp ]
sp = sorted(p, lambda x, y: cmp(x[2],y[2]))
for s in sp[-30:]:
	print '%20s%20s%20s' % (s[0], s[1].strip(), s[2])
a.find('a')
a.find('b')
filter(lambda x: x[1].find('茅台') >= 0, sp)
p = [ (i[0], i[1], max(i[2])) for i in pp ]
sp = sorted(p, lambda x, y: cmp(x[2],y[2]))
sp[-1]
len(filter(lambda x: x[2] >= 10, sp))
len(filter(lambda x: x[2] >= 10, sp))[:10]
filter(lambda x: x[2] >= 10, sp)[:10]
for s in filter(lambda x: x[2] >= 10, sp)[:30]:
	print '%20s%20s%20s' % (s[0], s[1].strip(), s[2])
for s in filter(lambda x: x[2] >= 20, sp)[:30]:
	print '%20s%20s%20s' % (s[0], s[1].strip(), s[2])
len(filter(lambda x: x[2] >= 20, sp))
len(filter(lambda x: x[2] >= 30, sp))
for s in filter(lambda x: x[2] >= 30, sp)[:300]:
	print '%20s%20s%20s' % (s[0], s[1].strip(), s[2])
p = [ (i[0], i[1], max(i[2])/min(i[2])) for i in pp ]
sp = sorted(p, lambda x, y: cmp(x[2],y[2]))
len(filter(lambda x: x[2] >= 30, sp))
for s in filter(lambda x: x[2] >= 30, sp)[:300]:
	print '%20s%20s%20s' % (s[0], s[1].strip(), s[2])
l
r
r1
p
dp = dict()
pp
dpp = dict()
for t in pp:
	pass
npp = dict()
for t in pp:
	npp[t[0][1:]] = t[1]
npp['000001']
print npp['000001']
ppp = dict()
for t in pp:
	ppp[t[0][1:]] = t[2]
s = '002151'
print npp[s]
max(ppp[s])
ppp[s][-1]
min(ppp[s])
def printS(code):
	global npp, ppp
	print code, npp[code], ppp[code][-1], max(ppp[code]), min(ppp[code])
printS('300124')
printS('300022')
printS('300299')
printS('002527')
printS('300034')
printS('300351')
printS('002364')
get_ipython().magic(u'save ppp')
help(%save)
get_ipython().magic(u'save')
get_ipython().magic(u'save analysis')
get_ipython().magic(u'save analysis.py')
get_ipython().magic(u"save 'analysis.py'")
get_ipython().magic(u"save ('analysis.py')")
