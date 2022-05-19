import os, csv

ip_table = []
coflows = {}

def load_ip_from_file():
    ip_table.append("")
    with open(path+"config/iptable.txt") as ipt:
        for ip in ipt:
            ip_table.append(ip[:-1])

def set_coflows_dict(name):
    with open(f"{path}instances/{name}/{name}.csv") as content:
        instance = csv.reader(content)
        next(instance)
        for flow in instance:
            coflow = int(flow[1])+1
            key = f"{flow[2]},{flow[3]},{int(float(flow[4])*1250000)}"
            coflows[key] = str(coflow)

def get_number_of_flows(name):
    with open(f"{path}instances/{name}/{name}.csv") as content:
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
            time = data.readline().split()[0]
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

# def bit_converter(size):
#     size = size-60
#     size = size/1250000
#     return float(f'{size:.2f}')

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
    with open(f"{path}times/{instance}/{instance}{algo}_{nr}.csv", "w+") as content:
        times = csv.writer(content)
        times.writerow(["coflow","source","destination","size","time"])
        for log in logs:
            with open(path+"logs/in/"+log) as data:
                dest = 0
                src = [0] * get_number_of_flows(instance)
                for line in data:
                    if (len(line.split()) == 12):
                        if (dest == 0):
                            dest = ip_table.index(line.split()[4])
                        num = get_iperf_flow_num(line.split()[2])
                        src[num-1] = ip_table.index(line.split()[9])
                    if (len(line.split()) == 9 or len(line.split()) == 10):
                        time = line.split()[0]
                        finish = str(calculatime(start, time))
                        num = get_iperf_flow_num(line.split()[2])
                        size = line.split()[5] if len(line.split()) == 9 else line.split()[6]
                        #volume = bit_converter(int(size))
                        print(f"{src[num-1]},{dest},{int(size)-60}")
                        times.writerow([coflows.get(f"{src[num-1]},{dest},{int(size)-60}"), src[num-1], dest, finish])
    print(coflows)

def extract_results(instance, algo, nr, number_of_machines):
    load_ip_from_file()
    set_coflows_dict(instance)
    get_number_of_flows(instance)
    get_startpoint()
    parse_results(instance, algo, nr, number_of_machines)

path = "/home/me/Work/multipass/"
logs = os.listdir(path+"logs/in/")

#extract_results("Cedric_1", "_op", 1, 4)