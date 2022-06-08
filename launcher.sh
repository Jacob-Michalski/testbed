#!/bin/bash

ssh PC7 iperf -c 10.28.206.12 -n 25330316 -S 0xBC > /dev/null 2> logs/out/1_7to6.txt &
ssh PC7 iperf -c 10.28.206.26 -n 18550883 -S 0x90 > /dev/null 2> logs/out/2_7to3.txt &
ssh PC4 iperf -c 10.28.206.205 -n 16621363 -S 0x90 > /dev/null 2> logs/out/2_4to9.txt &
ssh PC4 iperf -c 10.28.206.205 -n 17412183 -S 0x90 > /dev/null 2> logs/out/2_4to9.txt &
ssh PC8 iperf -c 10.28.206.88 -n 18419944 -S 0x90 > /dev/null 2> logs/out/2_8to1.txt &
ssh PC1 iperf -c 10.28.206.159 -n 16590419 -S 0x90 > /dev/null 2> logs/out/2_1to10.txt &
ssh PC3 iperf -c 10.28.206.159 -n 18945626 -S 0x90 > /dev/null 2> logs/out/2_3to10.txt &
ssh PC10 iperf -c 10.28.206.211 -n 18389044 -S 0x90 > /dev/null 2> logs/out/2_10to2.txt &
ssh PC10 iperf -c 10.28.206.205 -n 25671544 -S 0xC0 > /dev/null 2> logs/out/3_10to9.txt &
ssh PC6 iperf -c 10.28.206.26 -n 25551246 -S 0x9C > /dev/null 2> logs/out/4_6to3.txt &
ssh PC6 iperf -c 10.28.206.113 -n 27110070 -S 0xB0 > /dev/null 2> logs/out/5_6to5.txt &
ssh PC8 iperf -c 10.28.206.113 -n 26141122 -S 0x98 > /dev/null 2> logs/out/6_8to5.txt &
ssh PC8 iperf -c 10.28.206.88 -n 25680383 -S 0x94 > /dev/null 2> logs/out/7_8to1.txt &
ssh PC7 iperf -c 10.28.206.211 -n 24693436 -S 0xA8 > /dev/null 2> logs/out/8_7to2.txt &
ssh PC10 iperf -c 10.28.206.234 -n 24338055 -S 0xAC > /dev/null 2> logs/out/9_10to7.txt &
ssh PC8 iperf -c 10.28.206.26 -n 25359491 -S 0xB4 > /dev/null 2> logs/out/10_8to3.txt &
ssh PC4 iperf -c 10.28.206.88 -n 23017969 -S 0xC4 > /dev/null 2> logs/out/11_4to1.txt &
ssh PC5 iperf -c 10.28.206.211 -n 25468445 -S 0xB8 > /dev/null 2> logs/out/12_5to2.txt &
ssh PC2 iperf -c 10.28.206.234 -n 24264102 -S 0xC8 > /dev/null 2> logs/out/13_2to7.txt &
ssh PC4 iperf -c 10.28.206.12 -n 24845566 -S 0xA4 > /dev/null 2> logs/out/14_4to6.txt &
ssh PC5 iperf -c 10.28.206.88 -n 24046424 -S 0xA0 > /dev/null 2> logs/out/15_5to1.txt &
