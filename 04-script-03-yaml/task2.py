#!/usr/bin/env python3

import os
import sys
import time
import socket
import json
import yaml

dns = ["drive.google.com", "mail.google.com", "google.com"]

while (True):
    for d in dns:
        ip = socket.gethostbyname(d) 

        file = d + ".json"
        with open(file, 'w') as fw:
            data = {}
            data[d] = ip
            fw.write(json.dumps(data))
            print(json.dumps(data))

        file = d + ".yaml"
        with open(file, 'w') as fw:
            data = [{d: ip}]
            fw.write(yaml.dump(data))
            print(yaml.dump(data))
    time.sleep(1)
