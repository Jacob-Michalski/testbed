#!/bin/bash

launch_sinc () {
    python testbed.py sinc 1
    status=$?
    expected=$(cat instances/50M_Rachid/50M_Rachid_1.csv | wc -l)
    obtained=$(cat times/50M_Rachid/50M_Rachid_1_sinc.csv | wc -l)
    sleep 1
}

launch_op () {
    python testbed.py op 1
    status=$?
    expected=$(cat instances/50M_Rachid/50M_Rachid_1.csv | wc -l)
    obtained=$(cat times/50M_Rachid/50M_Rachid_1_op.csv | wc -l)
    sleep 1
}

# for ((i=1; i<=32; i++));
# do
#     ssh PC$i killall -9 iperf &
#     # wc -l instances/Rachid/Rachid_"$i".csv
#     # wc -l times/Rachid/Rachid_"$i"_sinc.csv
#     # echo " - "
# done

# retries=(2)
# for i in ${retries[@]};
for ((i=1; i<=50; i++))
do
    status=1
    while [ $status -ne 0 ]
    do
        launch_sinc $i
    done
    for ((x=0; x<2; x++));
    do
        if [ $expected -ne $obtained ] || [ $status -ne 0 ]
        then
            launch_sinc $i
        else
            break
        fi
    done
    diff=$(($expected-$obtained))
    if [ $diff -ne 0 ]
    then
        echo "$i -> $diff"  >> failed_tcp.txt
    fi
    launch_sinc $i
    launch_op $i
done

retries=(2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50)
for i in ${retries[@]};
for ((i=1; i<=50; i++))
do
    status=1
    while [ $status -ne 0 ]
    do
        launch_op $i
    done
    for ((x=0; x<5; x++));
    do
        if [ $expected -ne $obtained ] || [ $status -ne 0 ]
        then
            launch_op $i
        else
            break
        fi
    done
    diff=$(($expected-$obtained))
    if [ $diff -ne 0 ]
    then
        echo "$i -> $diff"  >> failed_op.txt
    fi
done