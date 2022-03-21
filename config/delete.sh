#!/bin/bash

j=200

for ((i=165; i <= $j; i++));
do
	multipass delete PC$i
done

multipass purge
