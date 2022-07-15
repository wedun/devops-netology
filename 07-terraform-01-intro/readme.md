# Задача 1. Выбор инструментов.
## Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый?
Для сервиса выберем неизменяемый тип инфраструктуры. Этот вариант позволит уменьшить влияние дрейфа инфраструктуры. Т.к. в команде есть опыт использования Terraform, Ansible, Packer то подготовка новых версий будет проходит в контролируемых условиях.
## Будет ли центральный сервер для управления инфраструктурой?
Нет, системам, которым нужен доступ для публикации релизов - предоставим нужные уровни доступа (TeamCity). Команде, которая работает с инфраструктуров предоставим доступ с рабочих компьютеров (для работы с Terraform, Kubernetes, Ansible)
# Будут ли агенты на серверах?
Нет, мы используем в этом сервисы системы без агентов на серверах (Используемый стек: Ansible, Terraform, Kubernetes, Docker не требуют наличия агентов для своей работы или могут работать через API).
# Будут ли использованы средства для управления конфигурацией или инициализации ресурсов?
Да, Ansible для управления конфигурацией, Terraform для инициализации ресурсов.
# Какие инструменты из уже используемых вы хотели бы использовать для нового проекта?
Packer, Terraform, Docker, Kubernetes, TeamCity, Ansible
# Хотите ли рассмотреть возможность внедрения новых инструментов для этого проекта?
Да, предложил бы заменить TeamCity на Gitlab CI. Но т.к. проект стартует сегодня, то запускаем проект с TeamCity и когда команда получит достаточный уровень компетенций в новом инструменте, то перейти в Gitlab CI.  

# Задача 2. Установка терраформ.
```
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

terraform --version
Terraform v1.2.5
on linux_amd64
```

# Задача 3. Поддержка легаси кода.
Скачаем версию terraform 0.12.6 и установим в систему. В результате мы получим последнюю версию terraform, установленную при помощи стандартного менеджера пакетов и устаревшую версию:   
Скачаем последнюю версию terraform с сайта разработчика, выдадим права на выполнение и скопируем в директорию /usr/bin или /usr/local/bin
```
terraform --version
Terraform v1.2.5
on linux_amd64

terraform_0.12.6 --version
Terraform v0.12.6

Your version of Terraform is out of date! The latest version
is 1.2.5. You can update by downloading from www.terraform.io/downloads.html
```
