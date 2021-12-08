# 1.
- Поместим файл в автозагрузку:
sudo systemctl enable node_exporter.service
- Добавление опций к запускаемому процессу реализовано черех параметр EnvironmentFile
- Файл /etc/default/node_exporter необходимо создать 
- Результат команд sudo systemctl start/stop node_exporter.service приведён на скриншотах, после перезагрузки сервис корректно запустился автоматически
# 2.
- Мониторинг CPU
Группа счётчиков node_cpu_*, пример node_cpu_seconds_total, node_cpu_guest_seconds_total
- Мониторинг сети
Группа счётчиков node_network_*, например node_network_transmit_packets_total, node_network_transmit_bytes_total
- Мониторинг памяти
Группа счётчиков node_memory_*, например node_memory_SwapFree_bytes, node_memory_Active_bytes
- Мониторинг диска
Группа счётчиков node_filesystem_*, например node_filesystem_size_bytes, node_filesystem_avail_bytes
# 3.
Запустил, скриншот прилагаю. Полезно, что есть комментарии к графикам.
# 4.
Да, можно. Команда:
sudo dmesg | grep "Hypervisor detected"
[    0.000000] Hypervisor detected: KVM
# 5.
fs.nr_open - параметр определяет максимальное число открытых файлов в одном процессе.
Значение по умолчанию можно получить командой:
cat /proc/sys/fs/nr_open
1048576
Однако достич такого значения не получится из-за ограничений накладываемых системой на процесс терминала и пораждаемые им процессы.
ulimit -a | grep open
open files                      (-n) 1024
Значение можно увеличить для текущей сисии терминала при помощи ulimit -n XXXXX. Новое значение не должно превышать жёсткий лимит для данного параметра (получить список жёстких лимитов можно при помощи ulimit -aH)


