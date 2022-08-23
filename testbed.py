import argparse, os, csv, time
from timing import extract_results
from coflowplot import graph

ip_table = []
flows = []
prio = []
duration = 0.0
dscp = ["", "0x10", "0x14", "0x18", "0x1C",
            "0x20", "0x24", "0x28", "0x2C",
            "0x30", "0x34", "0x38", "0x3C",
            "0x40", "0x44", "0x48", "0x4C",
            "0x50", "0x54", "0x58", "0x5C",
            "0x60", "0x64", "0x68", "0x6C",
            "0x70", "0x74", "0x78", "0x7C",
            "0x80", "0x84", "0x88", "0x8C",
            "0x90", "0x94", "0x98", "0x9C",
            "0xA0", "0xA4", "0xA8", "0xAC",
            "0xB0", "0xB4", "0xB8", "0xBC",
            "0xC0", "0xC4", "0xC8", "0xCC",
            "0xD0", "0xD4", "0xD8", "0xDC",
            "0xE0", "0xE4", "0xE8", "0xEC",
            "0xF0", "0xF4", "0xF8", "0xFC"]


def load_ip_from_file(filename):
    ip_table.append("")
    with open(filename) as adresses:
        for address in adresses:
            ip_table.append(address[:-1])

def load_flows_from_file(filename):
    global flows
    with open(filename) as content:
        instance = csv.reader(content)
        next(instance)
        for flow in instance:
            flow.pop(0)
            for i in range(len(flow)):
                if i == 3:
                    flow[i]=int(float(flow[i])*1250000)
                else:
                    flow[i]=int(flow[i])
            flows.append(flow)

def load_prio_from_file(filename):
    global prio
    with open(filename) as content:
        order = csv.reader(content)
        next(order)
        prio = [int(data) for data in next(order)]

def set_prio_to_flows():
    global flows, prio
    for flow in flows:
        flow[4] = prio.index(flow[0]+1)+1

def get_duration(filename):
    global duration
    with open(filename) as content:
        times = csv.reader(content)
        next(times)
        for time in next(times):
            duration = max(duration, float(time))
        duration = int(duration)

def get_number_of_machines():
    number = 0
    for flow in flows:
        number = flow[1] if flow[1] > number else number
        number = flow[2] if flow[2] > number else number
    return number+1

def get_number_of_coflows():
    number = 0
    for flow in flows:
        if flow[0] > number:
            number = flow[0]
    return number+1

def write_prioritization(number_of_machines):
    with open("prioritization.sh", "w") as prioritizarion:
        for i in range(1, number_of_machines):
            prioritizarion.write(f"scp tc_prio.sh PC{i}:~ && ssh PC{i} sudo bash tc_prio.sh &\n")

def prioritization():
    write_prioritization(get_number_of_machines())
    os.system("bash prioritization.sh >> /dev/null 2>&1")
    time.sleep(5)

def ssh_iperf(flow):
    return f"ssh PC{flow[1]} iperf -c {ip_table[flow[2]]} -n {flow[3]} -S {dscp[flow[4]]} > /dev/null 2> logs/out/{flow[0]+1}_{flow[1]}to{flow[2]}.txt &\n"

def write_launcher():
    with open("launcher.sh", "w") as launcher:
        launcher.write("#!/bin/bash\n\n")
        for flow in flows:
            launcher.write(ssh_iperf(flow))

def expedition():
    number_of_machines = get_number_of_machines()
    destination = [False] * number_of_machines
    for flow in flows:
        destination[flow[2]] = True
    write_launcher()
    for i in range(number_of_machines):
        if destination[i]:
            os.system(f"ssh PC{i} iperf -s -f b | ts %H:%M:%.S > logs/in/log{i}.txt &")
    time.sleep(1)
    os.system("bash launcher.sh")
    time.sleep(duration*1.2)
    for i in range(number_of_machines):
        if destination[i]:
            os.system(f"ssh PC{i} killall -9 iperf &")

def setup():
    load_ip_from_file("config/iptable.txt")
    load_flows_from_file(f"instances/{instance}/{instance}{nr}.csv")
    load_prio_from_file(f"instances/{instance}/{instance}{nr}_prio{algo}.csv")
    set_prio_to_flows()
    get_duration(f"instances/{instance}/{instance}{nr}_cct{algo}.csv")
    get_number_of_machines()

def clear_logs():
    os.system("rm logs/in/*.txt")
    os.system("rm logs/out/*.txt")


parser = argparse.ArgumentParser()
parser.add_argument('algo', type=str)
parser.add_argument('nr', type=str)
args = parser.parse_args()
instance = "Rachid11"
nr = f"_{args.nr}"
algo = f"_{args.algo}"
print(f"start{nr}")
clear_logs()
setup()
prioritization()
print("transfer started")
expedition()
print("transfer finished")
print("extracting data")
extract_results(instance, algo, nr)
print("data extracted")
print("making graph")
graph(instance, algo, nr, get_number_of_coflows())
print(f"end{nr}")