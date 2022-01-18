#!/usr/bin/env python3

import os
import sys
import time
import socket
import json

dns = ["drive.google.com", "mail.google.com", "google.com"]
ips = []

while (1 == 1):
    # Read json and compare dicts
    with open('result.json') as fr:
        pairsold = json.load(fr)

    for d in dns:
        ips.append(socket.gethostbyname(d))

    # Convert 2 lists to dict
    zip_iterator = zip(dns, ips)
    pairs = dict(zip_iterator)

    # Compare dicts
    for key in pairsold:
        oldip = pairsold[key]
        newip = pairs[key]
        if (oldip != newip):
            print(f'[ERROR] {key} IP mismatch: {oldip} {newip}')
        else:
            print(f'{key} - {newip}')

    with open('result.json', 'w') as fw:
        json.dump(pairs, fw)
    time.sleep(1)
