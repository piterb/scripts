#!/bin/bash

CONNETIONS=$1
URL=$2

for ((i=1;i<=$CONNETIONS;i++)); do 
	curl -s --header "Connection: keep-alive" "$URL" > /dev/null &
done

wait
