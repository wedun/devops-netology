#!/bin/bash

ips=("192.168.0.1" "173.194.222.113" "87.250.250.242")
error=0
while (($error == 0))
do
	curl --connect-timeout 3 http://${ips[0]}:80
	error=$?
	if (($error != 0))
        then
		echo ${ips[0]} >> error
		break
        fi

	curl --connect-timeout 3 http://${ips[1]}:80
	error=$?
	if (($error != 0))
	then
	        echo ${ips[1]} >> error
		break
	fi
	
	curl --connect-timeout 3 http://${ips[2]}:80
	error=$?
	if (($error != 0))
	then
	        echo ${ips[2]} >> error
		break
	fi
done
