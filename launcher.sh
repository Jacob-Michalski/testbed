#!/bin/bash

ssh PC1 sudo python3 sender.py 10.28.206.11 10.0 16 > logs/flows/1_1_5_10.0 &
ssh PC2 sudo python3 sender.py 10.28.206.11 10.0 20 > logs/flows/2_2_5_10.0 &
ssh PC3 sudo python3 sender.py 10.28.206.11 10.0 24 > logs/flows/3_3_5_10.0 &
ssh PC4 sudo python3 sender.py 10.28.206.11 10.0 28 > logs/flows/4_4_5_10.0 &
