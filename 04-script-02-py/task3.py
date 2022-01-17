#!/usr/bin/env python3

import os
import sys

repo_path=sys.argv[1]

if not os.path.exists(repo_path + '/.git'):
    print("It is not repo")
    sys.exit()

path_var=f'cd {repo_path}'

bash_command = [path_var, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False

for result in result_os.split('\n'):
        if result.find('modified') != -1:
            prepare_result = result.replace('\tmodified:   ', '')
            print(repo_path + prepare_result)
