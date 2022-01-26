#!/usr/bin/env python3

import os
import sys
import time
import socket

dns = ["drive.google.com", "mail.google.com", "google.com"]

while (True):
    for d in dns:
        ip = socket.gethostbyname(d) 

        file = d + ".json"
        with open(file, 'w') as fw:
            fw.write('{ ' + f'\"{d}\" : \"{ip}\"' + '}')
            print('{ ' + f'\"{d}\" : \"{ip}\"' + '}')

        file = d + ".yaml"
        with open(file, 'w') as fw:
            fw.write('- ' + f'{d}: {ip}')
            print('- ' + f'{d}: {ip}')
    time.sleep(1)
