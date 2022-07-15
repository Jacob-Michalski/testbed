#!/bin/bash

modprobe ifb numifbs=1
ip link set dev ifb0 up
tc qdisc del dev ens3 ingress
tc qdisc add dev ens3 handle ffff: ingress
tc filter add dev ens3 protocol ip parent ffff: u32 match u32 0 0 action mirred egress redirect dev ifb0

tc qdisc del dev ens3 root
tc qdisc add dev ens3 root handle 1: htb default 1
tc class add dev ens3 parent 1: classid 1:1 htb rate 10Mbit burst 10Mbit
tc qdisc add dev ens3 parent 1:1 handle 2: prio bands 16

tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x00 0xff flowid 2:1
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x04 0xff flowid 2:1
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x08 0xff flowid 2:1
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x0C 0xff flowid 2:1
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x10 0xff flowid 2:2
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x14 0xff flowid 2:2
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x18 0xff flowid 2:2
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x1C 0xff flowid 2:2
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x20 0xff flowid 2:3
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x24 0xff flowid 2:3
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x28 0xff flowid 2:3
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x2C 0xff flowid 2:3
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x30 0xff flowid 2:4
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x34 0xff flowid 2:4
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x38 0xff flowid 2:4
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x3C 0xff flowid 2:4
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x40 0xff flowid 2:5
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x44 0xff flowid 2:5
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x48 0xff flowid 2:5
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x4C 0xff flowid 2:5
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x50 0xff flowid 2:6
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x54 0xff flowid 2:6
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x58 0xff flowid 2:6
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x5C 0xff flowid 2:6
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x60 0xff flowid 2:7
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x64 0xff flowid 2:7
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x68 0xff flowid 2:7
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x6C 0xff flowid 2:7
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x70 0xff flowid 2:8
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x74 0xff flowid 2:8
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x78 0xff flowid 2:8
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x7C 0xff flowid 2:8
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x80 0xff flowid 2:9
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x84 0xff flowid 2:9
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x88 0xff flowid 2:9
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x8C 0xff flowid 2:9
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x90 0xff flowid 2:a
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x94 0xff flowid 2:a
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x98 0xff flowid 2:a
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0x9C 0xff flowid 2:a
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xA0 0xff flowid 2:b
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xA4 0xff flowid 2:b
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xA8 0xff flowid 2:b
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xAC 0xff flowid 2:b
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xB0 0xff flowid 2:c
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xB4 0xff flowid 2:c
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xB8 0xff flowid 2:c
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xBC 0xff flowid 2:c
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xC0 0xff flowid 2:d
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xC4 0xff flowid 2:d
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xC8 0xff flowid 2:d
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xCC 0xff flowid 2:d
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xD0 0xff flowid 2:e
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xD4 0xff flowid 2:e
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xD8 0xff flowid 2:e
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xDC 0xff flowid 2:e
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xE0 0xff flowid 2:f
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xE4 0xff flowid 2:f
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xE8 0xff flowid 2:f
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xEC 0xff flowid 2:f
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xF0 0xff flowid 2:10
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xF4 0xff flowid 2:10
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xF8 0xff flowid 2:10
tc filter add dev ens3 protocol ip parent 2: prio 1 u32 match ip tos 0xFC 0xff flowid 2:10
tc filter add dev ens3 protocol ip parent 2: prio 2 matchall flowid 2:1

tc qdisc add dev ens3 parent 2:2 handle 10: prio bands 4
tc qdisc add dev ens3 parent 2:3 handle 20: prio bands 4
tc qdisc add dev ens3 parent 2:4 handle 30: prio bands 4
tc qdisc add dev ens3 parent 2:5 handle 40: prio bands 4
tc qdisc add dev ens3 parent 2:6 handle 50: prio bands 4
tc qdisc add dev ens3 parent 2:7 handle 60: prio bands 4
tc qdisc add dev ens3 parent 2:8 handle 70: prio bands 4
tc qdisc add dev ens3 parent 2:9 handle 80: prio bands 4
tc qdisc add dev ens3 parent 2:a handle 90: prio bands 4
tc qdisc add dev ens3 parent 2:b handle 100: prio bands 4
tc qdisc add dev ens3 parent 2:c handle 110: prio bands 4
tc qdisc add dev ens3 parent 2:d handle 120: prio bands 4
tc qdisc add dev ens3 parent 2:e handle 130: prio bands 4
tc qdisc add dev ens3 parent 2:f handle 140: prio bands 4
tc qdisc add dev ens3 parent 2:10 handle 150: prio bands 4

tc filter add dev ens3 protocol ip parent 10: prio 1 u32 match ip tos 0x10 0xff flowid 10:1
tc filter add dev ens3 protocol ip parent 10: prio 1 u32 match ip tos 0x14 0xff flowid 10:2
tc filter add dev ens3 protocol ip parent 10: prio 1 u32 match ip tos 0x18 0xff flowid 10:3
tc filter add dev ens3 protocol ip parent 10: prio 1 u32 match ip tos 0x1C 0xff flowid 10:4
tc filter add dev ens3 protocol ip parent 20: prio 1 u32 match ip tos 0x20 0xff flowid 20:1
tc filter add dev ens3 protocol ip parent 20: prio 1 u32 match ip tos 0x24 0xff flowid 20:2
tc filter add dev ens3 protocol ip parent 20: prio 1 u32 match ip tos 0x28 0xff flowid 20:3
tc filter add dev ens3 protocol ip parent 20: prio 1 u32 match ip tos 0x2C 0xff flowid 20:4
tc filter add dev ens3 protocol ip parent 30: prio 1 u32 match ip tos 0x30 0xff flowid 30:1
tc filter add dev ens3 protocol ip parent 30: prio 1 u32 match ip tos 0x34 0xff flowid 30:2
tc filter add dev ens3 protocol ip parent 30: prio 1 u32 match ip tos 0x38 0xff flowid 30:3
tc filter add dev ens3 protocol ip parent 30: prio 1 u32 match ip tos 0x3C 0xff flowid 30:4
tc filter add dev ens3 protocol ip parent 40: prio 1 u32 match ip tos 0x40 0xff flowid 40:1
tc filter add dev ens3 protocol ip parent 40: prio 1 u32 match ip tos 0x44 0xff flowid 40:2
tc filter add dev ens3 protocol ip parent 40: prio 1 u32 match ip tos 0x48 0xff flowid 40:3
tc filter add dev ens3 protocol ip parent 40: prio 1 u32 match ip tos 0x4C 0xff flowid 40:4
tc filter add dev ens3 protocol ip parent 50: prio 1 u32 match ip tos 0x50 0xff flowid 50:1
tc filter add dev ens3 protocol ip parent 50: prio 1 u32 match ip tos 0x54 0xff flowid 50:2
tc filter add dev ens3 protocol ip parent 50: prio 1 u32 match ip tos 0x58 0xff flowid 50:3
tc filter add dev ens3 protocol ip parent 50: prio 1 u32 match ip tos 0x5C 0xff flowid 50:4
tc filter add dev ens3 protocol ip parent 60: prio 1 u32 match ip tos 0x60 0xff flowid 60:1
tc filter add dev ens3 protocol ip parent 60: prio 1 u32 match ip tos 0x64 0xff flowid 60:2
tc filter add dev ens3 protocol ip parent 60: prio 1 u32 match ip tos 0x68 0xff flowid 60:3
tc filter add dev ens3 protocol ip parent 60: prio 1 u32 match ip tos 0x6C 0xff flowid 60:4
tc filter add dev ens3 protocol ip parent 70: prio 1 u32 match ip tos 0x70 0xff flowid 70:1
tc filter add dev ens3 protocol ip parent 70: prio 1 u32 match ip tos 0x74 0xff flowid 70:2
tc filter add dev ens3 protocol ip parent 70: prio 1 u32 match ip tos 0x78 0xff flowid 70:3
tc filter add dev ens3 protocol ip parent 70: prio 1 u32 match ip tos 0x7C 0xff flowid 70:4
tc filter add dev ens3 protocol ip parent 80: prio 1 u32 match ip tos 0x80 0xff flowid 80:1
tc filter add dev ens3 protocol ip parent 80: prio 1 u32 match ip tos 0x84 0xff flowid 80:2
tc filter add dev ens3 protocol ip parent 80: prio 1 u32 match ip tos 0x88 0xff flowid 80:3
tc filter add dev ens3 protocol ip parent 80: prio 1 u32 match ip tos 0x8C 0xff flowid 80:4
tc filter add dev ens3 protocol ip parent 90: prio 1 u32 match ip tos 0x90 0xff flowid 90:1
tc filter add dev ens3 protocol ip parent 90: prio 1 u32 match ip tos 0x94 0xff flowid 90:2
tc filter add dev ens3 protocol ip parent 90: prio 1 u32 match ip tos 0x98 0xff flowid 90:3
tc filter add dev ens3 protocol ip parent 90: prio 1 u32 match ip tos 0x9C 0xff flowid 90:4
tc filter add dev ens3 protocol ip parent 100: prio 1 u32 match ip tos 0xA0 0xff flowid 100:1
tc filter add dev ens3 protocol ip parent 100: prio 1 u32 match ip tos 0xA4 0xff flowid 100:2
tc filter add dev ens3 protocol ip parent 100: prio 1 u32 match ip tos 0xA8 0xff flowid 100:3
tc filter add dev ens3 protocol ip parent 100: prio 1 u32 match ip tos 0xAC 0xff flowid 100:4
tc filter add dev ens3 protocol ip parent 110: prio 1 u32 match ip tos 0xB0 0xff flowid 110:1
tc filter add dev ens3 protocol ip parent 110: prio 1 u32 match ip tos 0xB4 0xff flowid 110:2
tc filter add dev ens3 protocol ip parent 110: prio 1 u32 match ip tos 0xB8 0xff flowid 110:3
tc filter add dev ens3 protocol ip parent 110: prio 1 u32 match ip tos 0xBC 0xff flowid 110:4
tc filter add dev ens3 protocol ip parent 120: prio 1 u32 match ip tos 0xC0 0xff flowid 120:1
tc filter add dev ens3 protocol ip parent 120: prio 1 u32 match ip tos 0xC4 0xff flowid 120:2
tc filter add dev ens3 protocol ip parent 120: prio 1 u32 match ip tos 0xC8 0xff flowid 120:3
tc filter add dev ens3 protocol ip parent 120: prio 1 u32 match ip tos 0xCC 0xff flowid 120:4
tc filter add dev ens3 protocol ip parent 130: prio 1 u32 match ip tos 0xD0 0xff flowid 130:1
tc filter add dev ens3 protocol ip parent 130: prio 1 u32 match ip tos 0xD4 0xff flowid 130:2
tc filter add dev ens3 protocol ip parent 130: prio 1 u32 match ip tos 0xD8 0xff flowid 130:3
tc filter add dev ens3 protocol ip parent 130: prio 1 u32 match ip tos 0xDC 0xff flowid 130:4
tc filter add dev ens3 protocol ip parent 140: prio 1 u32 match ip tos 0xE0 0xff flowid 140:1
tc filter add dev ens3 protocol ip parent 140: prio 1 u32 match ip tos 0xE4 0xff flowid 140:2
tc filter add dev ens3 protocol ip parent 140: prio 1 u32 match ip tos 0xE8 0xff flowid 140:3
tc filter add dev ens3 protocol ip parent 140: prio 1 u32 match ip tos 0xEC 0xff flowid 140:4
tc filter add dev ens3 protocol ip parent 150: prio 1 u32 match ip tos 0xF0 0xff flowid 150:1
tc filter add dev ens3 protocol ip parent 150: prio 1 u32 match ip tos 0xF4 0xff flowid 150:2
tc filter add dev ens3 protocol ip parent 150: prio 1 u32 match ip tos 0xF8 0xff flowid 150:3
tc filter add dev ens3 protocol ip parent 150: prio 1 u32 match ip tos 0xFC 0xff flowid 150:4

tc qdisc del dev ifb0 root
tc qdisc add dev ifb0 root handle 1: htb default 1
tc class add dev ifb0 parent 1: classid 1:1 htb rate 10Mbit burst 10Mbit
tc qdisc add dev ifb0 parent 1:1 handle 2: prio bands 16

tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x00 0xff flowid 2:1
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x04 0xff flowid 2:1
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x08 0xff flowid 2:1
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x0C 0xff flowid 2:1
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x10 0xff flowid 2:2
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x14 0xff flowid 2:2
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x18 0xff flowid 2:2
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x1C 0xff flowid 2:2
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x20 0xff flowid 2:3
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x24 0xff flowid 2:3
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x28 0xff flowid 2:3
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x2C 0xff flowid 2:3
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x30 0xff flowid 2:4
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x34 0xff flowid 2:4
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x38 0xff flowid 2:4
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x3C 0xff flowid 2:4
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x40 0xff flowid 2:5
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x44 0xff flowid 2:5
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x48 0xff flowid 2:5
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x4C 0xff flowid 2:5
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x50 0xff flowid 2:6
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x54 0xff flowid 2:6
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x58 0xff flowid 2:6
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x5C 0xff flowid 2:6
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x60 0xff flowid 2:7
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x64 0xff flowid 2:7
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x68 0xff flowid 2:7
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x6C 0xff flowid 2:7
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x70 0xff flowid 2:8
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x74 0xff flowid 2:8
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x78 0xff flowid 2:8
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x7C 0xff flowid 2:8
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x80 0xff flowid 2:9
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x84 0xff flowid 2:9
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x88 0xff flowid 2:9
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x8C 0xff flowid 2:9
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x90 0xff flowid 2:a
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x94 0xff flowid 2:a
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x98 0xff flowid 2:a
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0x9C 0xff flowid 2:a
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xA0 0xff flowid 2:b
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xA4 0xff flowid 2:b
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xA8 0xff flowid 2:b
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xAC 0xff flowid 2:b
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xB0 0xff flowid 2:c
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xB4 0xff flowid 2:c
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xB8 0xff flowid 2:c
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xBC 0xff flowid 2:c
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xC0 0xff flowid 2:d
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xC4 0xff flowid 2:d
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xC8 0xff flowid 2:d
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xCC 0xff flowid 2:d
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xD0 0xff flowid 2:e
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xD4 0xff flowid 2:e
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xD8 0xff flowid 2:e
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xDC 0xff flowid 2:e
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xE0 0xff flowid 2:f
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xE4 0xff flowid 2:f
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xE8 0xff flowid 2:f
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xEC 0xff flowid 2:f
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xF0 0xff flowid 2:10
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xF4 0xff flowid 2:10
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xF8 0xff flowid 2:10
tc filter add dev ifb0 protocol ip parent 2: prio 1 u32 match ip tos 0xFC 0xff flowid 2:10
tc filter add dev ifb0 protocol ip parent 2: prio 2 matchall flowid 2:1

tc qdisc add dev ifb0 parent 2:2 handle 10: prio bands 4
tc qdisc add dev ifb0 parent 2:3 handle 20: prio bands 4
tc qdisc add dev ifb0 parent 2:4 handle 30: prio bands 4
tc qdisc add dev ifb0 parent 2:5 handle 40: prio bands 4
tc qdisc add dev ifb0 parent 2:6 handle 50: prio bands 4
tc qdisc add dev ifb0 parent 2:7 handle 60: prio bands 4
tc qdisc add dev ifb0 parent 2:8 handle 70: prio bands 4
tc qdisc add dev ifb0 parent 2:9 handle 80: prio bands 4
tc qdisc add dev ifb0 parent 2:a handle 90: prio bands 4
tc qdisc add dev ifb0 parent 2:b handle 100: prio bands 4
tc qdisc add dev ifb0 parent 2:c handle 110: prio bands 4
tc qdisc add dev ifb0 parent 2:d handle 120: prio bands 4
tc qdisc add dev ifb0 parent 2:e handle 130: prio bands 4
tc qdisc add dev ifb0 parent 2:f handle 140: prio bands 4
tc qdisc add dev ifb0 parent 2:10 handle 150: prio bands 4

tc filter add dev ifb0 protocol ip parent 10: prio 1 u32 match ip tos 0x10 0xff flowid 10:1
tc filter add dev ifb0 protocol ip parent 10: prio 1 u32 match ip tos 0x14 0xff flowid 10:2
tc filter add dev ifb0 protocol ip parent 10: prio 1 u32 match ip tos 0x18 0xff flowid 10:3
tc filter add dev ifb0 protocol ip parent 10: prio 1 u32 match ip tos 0x1C 0xff flowid 10:4
tc filter add dev ifb0 protocol ip parent 20: prio 1 u32 match ip tos 0x20 0xff flowid 20:1
tc filter add dev ifb0 protocol ip parent 20: prio 1 u32 match ip tos 0x24 0xff flowid 20:2
tc filter add dev ifb0 protocol ip parent 20: prio 1 u32 match ip tos 0x28 0xff flowid 20:3
tc filter add dev ifb0 protocol ip parent 20: prio 1 u32 match ip tos 0x2C 0xff flowid 20:4
tc filter add dev ifb0 protocol ip parent 30: prio 1 u32 match ip tos 0x30 0xff flowid 30:1
tc filter add dev ifb0 protocol ip parent 30: prio 1 u32 match ip tos 0x34 0xff flowid 30:2
tc filter add dev ifb0 protocol ip parent 30: prio 1 u32 match ip tos 0x38 0xff flowid 30:3
tc filter add dev ifb0 protocol ip parent 30: prio 1 u32 match ip tos 0x3C 0xff flowid 30:4
tc filter add dev ifb0 protocol ip parent 40: prio 1 u32 match ip tos 0x40 0xff flowid 40:1
tc filter add dev ifb0 protocol ip parent 40: prio 1 u32 match ip tos 0x44 0xff flowid 40:2
tc filter add dev ifb0 protocol ip parent 40: prio 1 u32 match ip tos 0x48 0xff flowid 40:3
tc filter add dev ifb0 protocol ip parent 40: prio 1 u32 match ip tos 0x4C 0xff flowid 40:4
tc filter add dev ifb0 protocol ip parent 50: prio 1 u32 match ip tos 0x50 0xff flowid 50:1
tc filter add dev ifb0 protocol ip parent 50: prio 1 u32 match ip tos 0x54 0xff flowid 50:2
tc filter add dev ifb0 protocol ip parent 50: prio 1 u32 match ip tos 0x58 0xff flowid 50:3
tc filter add dev ifb0 protocol ip parent 50: prio 1 u32 match ip tos 0x5C 0xff flowid 50:4
tc filter add dev ifb0 protocol ip parent 60: prio 1 u32 match ip tos 0x60 0xff flowid 60:1
tc filter add dev ifb0 protocol ip parent 60: prio 1 u32 match ip tos 0x64 0xff flowid 60:2
tc filter add dev ifb0 protocol ip parent 60: prio 1 u32 match ip tos 0x68 0xff flowid 60:3
tc filter add dev ifb0 protocol ip parent 60: prio 1 u32 match ip tos 0x6C 0xff flowid 60:4
tc filter add dev ifb0 protocol ip parent 70: prio 1 u32 match ip tos 0x70 0xff flowid 70:1
tc filter add dev ifb0 protocol ip parent 70: prio 1 u32 match ip tos 0x74 0xff flowid 70:2
tc filter add dev ifb0 protocol ip parent 70: prio 1 u32 match ip tos 0x78 0xff flowid 70:3
tc filter add dev ifb0 protocol ip parent 70: prio 1 u32 match ip tos 0x7C 0xff flowid 70:4
tc filter add dev ifb0 protocol ip parent 80: prio 1 u32 match ip tos 0x80 0xff flowid 80:1
tc filter add dev ifb0 protocol ip parent 80: prio 1 u32 match ip tos 0x84 0xff flowid 80:2
tc filter add dev ifb0 protocol ip parent 80: prio 1 u32 match ip tos 0x88 0xff flowid 80:3
tc filter add dev ifb0 protocol ip parent 80: prio 1 u32 match ip tos 0x8C 0xff flowid 80:4
tc filter add dev ifb0 protocol ip parent 90: prio 1 u32 match ip tos 0x90 0xff flowid 90:1
tc filter add dev ifb0 protocol ip parent 90: prio 1 u32 match ip tos 0x94 0xff flowid 90:2
tc filter add dev ifb0 protocol ip parent 90: prio 1 u32 match ip tos 0x98 0xff flowid 90:3
tc filter add dev ifb0 protocol ip parent 90: prio 1 u32 match ip tos 0x9C 0xff flowid 90:4
tc filter add dev ifb0 protocol ip parent 100: prio 1 u32 match ip tos 0xA0 0xff flowid 100:1
tc filter add dev ifb0 protocol ip parent 100: prio 1 u32 match ip tos 0xA4 0xff flowid 100:2
tc filter add dev ifb0 protocol ip parent 100: prio 1 u32 match ip tos 0xA8 0xff flowid 100:3
tc filter add dev ifb0 protocol ip parent 100: prio 1 u32 match ip tos 0xAC 0xff flowid 100:4
tc filter add dev ifb0 protocol ip parent 110: prio 1 u32 match ip tos 0xB0 0xff flowid 110:1
tc filter add dev ifb0 protocol ip parent 110: prio 1 u32 match ip tos 0xB4 0xff flowid 110:2
tc filter add dev ifb0 protocol ip parent 110: prio 1 u32 match ip tos 0xB8 0xff flowid 110:3
tc filter add dev ifb0 protocol ip parent 110: prio 1 u32 match ip tos 0xBC 0xff flowid 110:4
tc filter add dev ifb0 protocol ip parent 120: prio 1 u32 match ip tos 0xC0 0xff flowid 120:1
tc filter add dev ifb0 protocol ip parent 120: prio 1 u32 match ip tos 0xC4 0xff flowid 120:2
tc filter add dev ifb0 protocol ip parent 120: prio 1 u32 match ip tos 0xC8 0xff flowid 120:3
tc filter add dev ifb0 protocol ip parent 120: prio 1 u32 match ip tos 0xCC 0xff flowid 120:4
tc filter add dev ifb0 protocol ip parent 130: prio 1 u32 match ip tos 0xD0 0xff flowid 130:1
tc filter add dev ifb0 protocol ip parent 130: prio 1 u32 match ip tos 0xD4 0xff flowid 130:2
tc filter add dev ifb0 protocol ip parent 130: prio 1 u32 match ip tos 0xD8 0xff flowid 130:3
tc filter add dev ifb0 protocol ip parent 130: prio 1 u32 match ip tos 0xDC 0xff flowid 130:4
tc filter add dev ifb0 protocol ip parent 140: prio 1 u32 match ip tos 0xE0 0xff flowid 140:1
tc filter add dev ifb0 protocol ip parent 140: prio 1 u32 match ip tos 0xE4 0xff flowid 140:2
tc filter add dev ifb0 protocol ip parent 140: prio 1 u32 match ip tos 0xE8 0xff flowid 140:3
tc filter add dev ifb0 protocol ip parent 140: prio 1 u32 match ip tos 0xEC 0xff flowid 140:4
tc filter add dev ifb0 protocol ip parent 150: prio 1 u32 match ip tos 0xF0 0xff flowid 150:1
tc filter add dev ifb0 protocol ip parent 150: prio 1 u32 match ip tos 0xF4 0xff flowid 150:2
tc filter add dev ifb0 protocol ip parent 150: prio 1 u32 match ip tos 0xF8 0xff flowid 150:3
tc filter add dev ifb0 protocol ip parent 150: prio 1 u32 match ip tos 0xFC 0xff flowid 150:4
