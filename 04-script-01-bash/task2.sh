#!/bin/bash

ips=("192.168.0.1" "173.194.222.113" "87.250.250.242")

for i in "${ips[@]}"
do
    while ((j < 5))
	do
	    let "j+=1"
	    curl --connect-timeout 3 http://$i:80 
	    if (($? != 0))
            then
                date >> curl.log
	    else
		break
            fi
	done
done
