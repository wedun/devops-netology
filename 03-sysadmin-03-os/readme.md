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
В первую секунду после запуска после запуска в вывод opensnoop-bpfcc попали обращения к файлам в директории /proc/PID/io, /proc/PID/status, /proc/PID/stat, /proc/PID/fd и к файлам в директории /sys/fs/cgroup/memory/system.slice/
# 6.
muname -a использует системный вызов uname()
Цитата из man
```Part of the utsname information is also accessible via
/proc/sys/kernel/{ostype, hostname, osrelease, version,
domainname}.
```
# 7.
Символ ; позволяет запускать команды последовательно. Однако каждая из команд не влияют на успешность выполнения всех команд в строке.
В отличии от ; символ && позволяет проверить что все команды в строке будут выполнены успешно. Если одна из завершит свою работу не с кодом 0, то система вернёт код ошибки для всей строки команд.
Команды set -e и && хоть и позволяют получить одинаковый результат, использование && является более предпочтительным из-за удобства использования этого оператора в командах и скриптах.
# 8. 
set -euxo pipefail позволяет получить значения всех переменных и получить одназначные коды завершения для всех команд или подробное выполняемых команд:
-e - немедленно выйти, если команда завершилась с кодом, отличным от нуля
-u - проверить подстановку переменных и завершиться с ошибкой, если дял переменной нет значения
-x - вывести команды и их аргументы по мере их выполнения
-o pipefail - позволяет гарантировать что все команды в наборе выполнились с нулевым кодом, в противном случае будет возвращён статус последней команды завершившийс с ненулевым статусом.
# 9.
Самый популярный статус процессов в linux "S Interruptible sleep (waiting for an event to complete)"
Дополнительна буквы означают:
```< high-priority (not nice to other users)
N low-priority (nice to other users)
L has pages locked into memory (for real-time and custom IO)
s is a session leader
l is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
+ is in the foreground process group
```
