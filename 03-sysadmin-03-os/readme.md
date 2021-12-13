# 1.
Запускаем команду:
strace /bin/bash -c 'cd /tmp' 2>2.txt
В файле находим системный вызов chdir()
execve("/bin/bash", ["/bin/bash", "-c", "cd /tmp"], 0x7ffcc915b450 /* 20 vars */) = 0
stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
chdir("/tmp")
# 2.
```strace file /dev/tty 2>2.txt
stat("/home/laykomdn/.magic.mgc", 0x7fff7d541820) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
```
База данных утилиты file расположена в /etc/magic и в скомпилированном файле /usr/share/misc/magic.mgc. Или в деректории /usr/share/misc/magic, если скомпилированная версия не существует.
Это поведение может быть переопределено, если существуют файлы $HOME/.magic.mgc или $HOME/.magic. В первую очередь система будет обращаться к этим файлам.
# 3.
Для обнуления открытого файла можно воспользоваться следующим способом:
```lsof | grep deleted
echo > /proc/(pid)/fd/(filedescriptor)
```
Где pid и filedescriptor - это идентафикаторы процесса из выводы команды lsof
# 4
Зомби процессы не занимают ресурсы системы (CPU, RAM, IO). Они занимают только ресурс таблицы процессов. Если таблица процессов будет заполнена, то пользователь не сможет продолжить работц.
# 5

