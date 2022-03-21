import argparse
import os
import collections
from secrets import token_hex
from coflowplot import graph

def iptonum(line, index, iptable):
    i = 1
    ref = line.split()[index] + '\n'
    for ip in iptable:
        if (ref == ip):
            break
        else:
            i+=1
    return str(i)

def reftonum(line, index):
    ref = line.split()[index]
    num = ""
    for char in ref:
        if (char != ']'):
            num = num + char
    num = int(num)
    return num

def calculatime(start, time):
    starther = int(start.split(':')[0])
    startmin = int(start.split(':')[1])
    startsec = float(start.split(':')[2])
    timeher = int(time.split(':')[0])
    timemin = int(time.split(':')[1])
    timesec = float(time.split(':')[2])
    if (timeher == starther):
        if (timemin == startmin):
            time = timesec-startsec
        else:
            diff = timemin-startmin-1
            time = 60-startsec+timesec+60*diff
    else:
        before = (60-startmin-1)*60 + (60-startsec)
        after = timemin*60 + timesec
        time = before + after
    return time

import argparse

parser = argparse.ArgumentParser()
parser.add_argument('instance', type=str)
parser.add_argument('number', type=str)
args = parser.parse_args()
name = args.instance
nr = args.number
path = "/home/me/Work/multipass/"
logs = os.listdir(path+"logs/in/")
minimum = 6000.0
start = ""
for log in logs:
    f = open(path+"logs/in/"+log, "r")
    for i in range (4):
        f.readline()
    time = f.readline().split()[0]
    startpoint = time.split(':')[1]+time.split(':')[2]
    if (minimum > float(startpoint)):
        start = time
        minimum = float(startpoint)
    f.close()
coflows = dict()
with open(path+"instances/"+name+".csv") as instance:
    for line in instance:
        if (line.split(',')[0] != "flowID"):
            data = line.split(',')
            coflow = int(data[1])+1
            key = data[2]+','+data[3]
            coflows[key] = str(coflow)
instance.close()
iptable = []
with open(path+"config/iptable.txt") as ipt:
    for ip in ipt:
        iptable.append(ip)
ipt.close()
# id = token_hex(8)
algo = ""
with open(f"{path}times/{name}/{name}{algo}_({nr}).csv", "w+") as times:
    times.write("coflow,source,destination,time\n")
    for log in logs:
        with open(path+"logs/in/"+log) as file:
            dest = 0
            src = [0] * 64
            for line in file:
                if (len(line.split()) == 12):
                    if (dest == 0):
                        dest = iptonum(line, 4, iptable)
                    num = reftonum(line, 2)
                    src[num] = iptonum(line, 9, iptable)
                if (len(line.split()) == 9 or len(line.split()) == 10):
                    time = line.split()[0]
                    finish = str(calculatime(start, time))
                    num = reftonum(line, 2)
                    times.write(coflows.get(src[num]+','+dest)+','+src[num]+','+dest+','+finish+'\n')
        file.close()
    # print(id)
times.close()
graph(name, nr)
