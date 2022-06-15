import os, csv

class MissingTransmissionException(Exception):
    pass

class DuplicateSizeException(Exception):
    pass

ip_table = []
coflows = {}
logs = []

def reset():
    global ip_table, coflows, logs
    ip_table.clear() 
    coflows.clear()
    logs.clear()

def load_ip_from_file():
    ip_table.append("")
    with open(path+"config/iptable.txt") as ipt:
        for ip in ipt:
            ip_table.append(ip[:-1])

def set_coflows_dict(name, nr):
    with open(f"{path}instances/{name}/{name}{nr}.csv") as content:
        instance = csv.reader(content)
        next(instance)
        for flow in instance:
            coflow = int(flow[1])+1
            key = f"{flow[2]},{flow[3]},{int(float(flow[4])*1250000)}"
            try:
                if coflows.get(key) == None:
                    coflows[key] = str(coflow)
                else:
                    raise DuplicateSizeException
            except DuplicateSizeException:
                print("Duplicate size for two flows with same source and destination")

def get_number_of_flows(name, nr):
    with open(f"{path}instances/{name}/{name}{nr}.csv") as content:
        instance = csv.reader(content)
        next(instance)
        number = 0
        for flow in instance:
            number+=1
        return number

def get_startpoint():
    start = ""
    minimum = 236000.0
    for log in logs:
        with open(path+"logs/in/"+log) as data:
            for i in range(4):
                data.readline()
            try:
                time = data.readline().split()[0]
                if not time:
                    raise MissingTransmissionException
            except MissingTransmissionException:
                print("Missing transmission, please retry the experiment")
            unit = time.split(":")
            startpoint = unit[0]+unit[1]+unit[2]
            if (float(startpoint) < minimum):
                if float(startpoint) < 20000 and minimum > 220000 and minimum != 236000.0:
                    pass
                else:
                    start = time
                    minimum = float(startpoint)
    return start

def get_iperf_flow_num(data):
    num = ""
    for char in data:
        if (char != ']'):
            num = num + char
    return int(num)

def calculatime(start, time):
    start_hour, start_min, start_sec = start.split(':')
    start_hour, start_min, start_sec = int(start_hour), int(start_min), float(start_sec)
    time_hour, time_min, time_sec = time.split(':')
    time_hour, time_min, time_sec = int(time_hour), int(time_min), float(time_sec)
    if time_hour == start_hour:
        if time_min == start_min:
            time = time_sec-start_sec
        else:
            diff = time_min-start_min-1
            time = 60-start_sec+time_sec+60*diff
    else:
        if time_hour-start_hour < 0:
            before = (24-start_hour-1)*3600+(60-start_min-1)*60+(60-start_sec)
            after = time_hour*3600+time_min*60+time_sec
        elif time_hour-start_hour > 1:
            before = (time_hour-start_hour-1)*3600+(60-start_min-1)*60+(60-start_sec)
            after = time_min*60+time_sec
        else:
            before = (60-start_min-1)*60+(60-start_sec)
            after = time_min*60+time_sec
        time = before + after
    return round(time, 3)
    
def parse_results(instance, algo, nr, number_of_machines):
    start = get_startpoint()
    if not os.path.isdir(f"{path}times/{instance}"):
        os.mkdir(f"{path}times/{instance}")
    with open(f"{path}times/{instance}/{instance}{nr}{algo}.csv", "w+") as content:
        times = csv.writer(content)
        times.writerow(["coflow","source","destination","time"])
        for log in logs:
            with open(path+"logs/in/"+log) as data:
                dest = 0
                src = [0] * 255
                for line in data:
                    if (len(line.split()) == 12):
                        if (dest == 0):
                            dest = ip_table.index(line.split()[4])
                        num = get_iperf_flow_num(line.split()[2])
                        src[num] = ip_table.index(line.split()[9])
                    if (len(line.split()) == 9 or len(line.split()) == 10):
                        time = line.split()[0]
                        finish = str(calculatime(start, time))
                        num = get_iperf_flow_num(line.split()[2])
                        size = line.split()[5] if len(line.split()) == 9 else line.split()[6]
                        times.writerow([coflows.get(f"{src[num]},{dest},{int(size)-60}"), src[num], dest, finish])

def extract_results(instance, algo, nr, number_of_machines):
    reset()
    global logs
    logs = os.listdir(path+"logs/in/")
    load_ip_from_file()
    set_coflows_dict(instance, nr)
    get_number_of_flows(instance, nr)
    get_startpoint()
    parse_results(instance, algo, nr, number_of_machines)

path = "/home/me/Work/multipass/"
