### Как сдавать задания

Вы уже изучили блок «Системы управления версиями», и начиная с этого занятия все ваши работы будут приниматься ссылками на .md-файлы, размещённые в вашем публичном репозитории.

Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-02-py/README.md). Заполните недостающие части документа решением задач (заменяйте `???`, ОСТАЛЬНОЕ В ШАБЛОНЕ НЕ ТРОГАЙТЕ чтобы не сломать форматирование текста, подсветку синтаксиса и прочее, иначе можно отправиться на доработку) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желани.

# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | TypeError: unsupported operand type(s) for +: 'int' and 'str'. Получили ошибку, т.к. у a и b разные типы данных  |
| Как получить для переменной `c` значение 12?  | Изменить тип переменной a на строку, a = '1', остальной скрипт оставить без изменений  |
| Как получить для переменной `c` значение 3?  | Изменить тип переменной b на число, b = 2, остальной скрипт оставить изменений  |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
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
```

### Вывод скрипта при запуске при тестировании:
```
laykomdn@rubius180:~/devops-netology/04-script-02-py$ ./task2.py
~/devops-netology/04-script-02-py/task1.py
~/devops-netology/04-script-02-py/task2.py
laykomdn@rubius180:~/devops-netology/04-script-02-py$ git status
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   task1.py
        modified:   task2.py

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        ../03-sysadmin-02-terminal/out.txt
        ../03-sysadmin-03-os/1/
        ../03-sysadmin-03-os/2.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
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
???
```

### Вывод скрипта при запуске при тестировании:
```
laykomdn@rubius180:~$ ./task3.py ~/devops-netology/
/home/laykomdn/devops-netology/04-script-02-py/readme.md
/home/laykomdn/devops-netology/04-script-02-py/task1.py
/home/laykomdn/devops-netology/04-script-02-py/task2.py
laykomdn@rubius180:~$ ./task3.py ~/
It is not repo
```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
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
```

### Вывод скрипта при запуске при тестировании:
```
laykomdn@rubius180:~/devops-netology/04-script-02-py$ ./task4.py
drive.google.com - 64.233.165.194
[ERROR] mail.google.com IP mismatch: 173.194.222.17 173.194.222.19
[ERROR] google.com IP mismatch: 142.251.1.139 74.125.131.138
drive.google.com - 64.233.165.194
mail.google.com - 173.194.222.19
google.com - 74.125.131.138
drive.google.com - 64.233.165.194
mail.google.com - 173.194.222.19
google.com - 74.125.131.138
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз переносить архив с нашими изменениями с сервера на наш локальный компьютер, формировать новую ветку, коммитить в неё изменения, создавать pull request (PR) и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. Мы хотим максимально автоматизировать всю цепочку действий. Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым). При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. С директорией локального репозитория можно делать всё, что угодно. Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

### Ваш скрипт:
```python
???
```

### Вывод скрипта при запуске при тестировании:
```
???
```
