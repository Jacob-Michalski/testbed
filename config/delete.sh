#!/bin/bash

j=134

for ((i=101; i <= $j; i++));
do
	multipass delete PC$i
done

multipass purge
