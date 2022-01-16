#!/bin/bash

ips=("192.168.0.1" "173.194.222.113" "87.250.250.242")
error=0
while (($error == 0))
do
    for i in "${ips[@]}"
    do
	curl --connect-timeout 3 http://$i:80
	error=$?
	if (($error != 0))
        then
		echo ${ips[0]} >> error
		break
        fi
    done
done
