# Создать собственный образ операционной системы с помощью Packer.
![packer-vm.png](packer-vm.png)
# Создать вашу первую виртуальную машину в Яндекс.Облаке.
## Для получения файла key.json выполним команду:  
```
yc iam key create --service-account-name default-sa --output key.json
```
Выполним terraform apply, получим виртуальную машину:  
![task2.png](task2.png)
# Развернём систему мониторинга:  
Скопируем IP адрес из предудущего шага и укажем его в файле inventory
Выполним ansible-playbook provision.yml
Результат работы доступен по адресу: [grafana](https://51.250.86.36:3000)  
![task3.png](task3.png)
