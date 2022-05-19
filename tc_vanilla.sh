#!/bin/bash

modprobe ifb numifbs=1
ip link set dev ifb0 up
tc qdisc del dev ens3 ingress
tc qdisc add dev ens3 handle ffff: ingress
tc filter add dev ens3 protocol ip parent ffff: u32 match u32 0 0 action mirred egress redirect dev ifb0

tc qdisc del dev ens3 root
tc qdisc add dev ens3 root handle 1: htb default 1
tc class add dev ens3 parent 1: classid 1:1 htb rate 10Mbit burst 10Mbit

tc qdisc del dev ifb0 root
tc qdisc add dev ifb0 root handle 1: htb default 1
tc class add dev ifb0 parent 1: classid 1:1 htb rate 10Mbit burst 10Mbit
