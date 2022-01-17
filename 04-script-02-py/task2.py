#!/usr/bin/env python3

import os

repo_path="~/devops-netology/"

bash_command = ["cd ~/devops-netology", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False

for result in result_os.split('\n'):
        if result.find('modified') != -1:
            prepare_result = result.replace('\tmodified:   ', '')
            print(repo_path + prepare_result)
            #break
