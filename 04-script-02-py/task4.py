#!/usr/bin/env python3

import os
import sys
import time
import socket

dns = ["drive.google.com", "mail.google.com", "google.com"]
ips = []

for d in dns:
    ips.append(socket.gethostbyname(d))

#dip = {"d" : ip1, "m" : ip2, "g" : ip3}
while (1 == 1):
    for i in range(len(dns)):
        print(f'{dns[i]} - {ips[i]}')
        time.sleep(1)
