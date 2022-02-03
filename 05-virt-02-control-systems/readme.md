## Задание 1

### Опишите своими словами основные преимущества применения на практике IaaC паттернов.

Преимущества использования подхода IaaC:  
1. Получение одинакового результата при любом коллечестве повторений одной операциию. Этот подход получает получить понятный, повторимый, повторяющийся результатю. Это преимущество называется идемпотентность.  
2. Более быстрое получение окружений для разработчи и тестирования.  
3. Маштабирование системы в большую или меньшую сторону.  
4. Устранение дрейфа конфигурации.  
5. Отказ от конфигурирования окружений в ручном режиме.
Какой из принципов IaaC является основополагающим?
Оновополагающим принципом является принцип идепотентности. Он позволяет получить одинаковый и повторяемый результат при ыполнении одного повторяющегося действия. Вне зависимости от времени и других факторов, когда это действие выполняется.

## Задание 2

### Чем Ansible выгодно отличается от других систем управление конфигурациями?

1. Простота настройки и использования.  
2. Использует YAML язык для описания конфигурации.  
3. Использует декларативный подход.  
4. Не использует агенты / использует push модель доставки. Меньше рисков безопасности.  
5. Легко масштабируется.  
6. Легко обеспечить высокую доступность (поддерживаются резервные серверы).  

### Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

Оба метода достаточно надёжны и могут использоваться для обслуживания production систем.  
Я предпочёт бы использовать систему конфигурации, использующую push модель из-за лучшего контроля доставки конфигурации и простоты использования. Однако в сверхбольших системах можно обратить внимание на систему работы с конфигурацией с поддержкой pull модели, т.к. её проще масштабировать и получение обновлений меньше зависит от сервера и происходит асинхронно в отличии от систем с поддержкой push модели.  

## Задание 3
 
```bat
VirtualBox

PS C:\Users\layko> VBoxManage.exe list vms
"netology" {f764c5ce-91be-47ee-b80c-a97921304de0}
```
```bat
Vagrant

PS C:\Users\layko> vagrant
Usage: vagrant [options] <command> [<args>]

    -h, --help                       Print this help.

Common commands:
     autocomplete    manages autocomplete installation on host
     box             manages boxes: installation, removal, etc.
     cloud           manages everything related to Vagrant Cloud
     destroy         stops and deletes all traces of the vagrant machine
     global-status   outputs status Vagrant environments for this user
     halt            stops the vagrant machine
     help            shows the help for a subcommand
     init            initializes a new Vagrant environment by creating a Vagrantfile
     login
     package         packages a running vagrant environment into a box
     plugin          manages plugins: install, uninstall, update, etc.
     port            displays information about guest port mappings
     powershell      connects to machine via powershell remoting
     provision       provisions the vagrant machine
     push            deploys code in this environment to a configured destination
     rdp             connects to machine via RDP
     reload          restarts vagrant machine, loads new Vagrantfile configuration
     resume          resume a suspended vagrant machine
     snapshot        manages snapshots: saving, restoring, etc.
     ssh             connects to machine via SSH
     ssh-config      outputs OpenSSH valid configuration to connect to the machine
     status          outputs status of the vagrant machine
     suspend         suspends the machine
     up              starts and provisions the vagrant environment
     upload          upload to machine via communicator
     validate        validates the Vagrantfile
     version         prints current and latest Vagrant version
     winrm           executes commands on a machine via WinRM
     winrm-config    outputs WinRM configuration to connect to the machine

For help on any individual command run `vagrant COMMAND -h`

Additional subcommands are available, but are either more advanced
or not commonly used. To see all subcommands, run the command
`vagrant list-commands`.
        --[no-]color                 Enable or disable color output
        --machine-readable           Enable machine readable output
    -v, --version                    Display Vagrant version
        --debug                      Enable debug output
        --timestamp                  Enable timestamps on log output
        --debug-timestamp            Enable debug output with timestamps
        --no-tty                     Enable non-interactive output
```

```bash
Ansible

$ ansible
Usage: ansible <host-pattern> [options]

Define and run a single task 'playbook' against a set of hosts

Options:
  -a MODULE_ARGS, --args=MODULE_ARGS
                        module arguments
  --ask-vault-pass      ask for vault password
  -B SECONDS, --background=SECONDS
                        run asynchronously, failing after X seconds
                        (default=N/A)
  -C, --check           don't make any changes; instead, try to predict some
                        of the changes that may occur
  -D, --diff            when changing (small) files and templates, show the
                        differences in those files; works great with --check
  -e EXTRA_VARS, --extra-vars=EXTRA_VARS
                        set additional variables as key=value or YAML/JSON, if
                        filename prepend with @
  -f FORKS, --forks=FORKS
                        specify number of parallel processes to use
                        (default=5)
  -h, --help            show this help message and exit
  -i INVENTORY, --inventory=INVENTORY, --inventory-file=INVENTORY
                        specify inventory host path or comma separated host
                        list. --inventory-file is deprecated
  -l SUBSET, --limit=SUBSET
                        further limit selected hosts to an additional pattern
  --list-hosts          outputs a list of matching hosts; does not execute
                        anything else
  -m MODULE_NAME, --module-name=MODULE_NAME
                        module name to execute (default=command)
  -M MODULE_PATH, --module-path=MODULE_PATH
                        prepend colon-separated path(s) to module library (def
                        ault=~/.ansible/plugins/modules:/usr/share/ansible/plu
                        gins/modules)
  -o, --one-line        condense output
  --playbook-dir=BASEDIR
                        Since this tool does not use playbooks, use this as a
                        substitute playbook directory.This sets the relative
                        path for many features including roles/ group_vars/
                        etc.
  -P POLL_INTERVAL, --poll=POLL_INTERVAL
                        set the poll interval if using -B (default=15)
  --syntax-check        perform a syntax check on the playbook, but do not
                        execute it
  -t TREE, --tree=TREE  log output to this directory
  --vault-id=VAULT_IDS  the vault identity to use
  --vault-password-file=VAULT_PASSWORD_FILES
                        vault password file
  -v, --verbose         verbose mode (-vvv for more, -vvvv to enable
                        connection debugging)
  --version             show program's version number, config file location,
                        configured module search path, module location,
                        executable location and exit

  Privilege Escalation Options:
    control how and which user you become as on target hosts

    -b, --become        run operations with become (does not imply password
                        prompting)
    --become-method=BECOME_METHOD
                        privilege escalation method to use (default=sudo), use
                        `ansible-doc -t become -l` to list valid choices.
    --become-user=BECOME_USER
                        run operations as this user (default=root)
    -K, --ask-become-pass
                        ask for privilege escalation password

  Connection Options:
    control as whom and how to connect to hosts

    -k, --ask-pass      ask for connection password
    --private-key=PRIVATE_KEY_FILE, --key-file=PRIVATE_KEY_FILE
                        use this file to authenticate the connection
    -u REMOTE_USER, --user=REMOTE_USER
                        connect as this user (default=None)
    -c CONNECTION, --connection=CONNECTION
                        connection type to use (default=smart)
    -T TIMEOUT, --timeout=TIMEOUT
                        override the connection timeout in seconds
                        (default=10)
    --ssh-common-args=SSH_COMMON_ARGS
                        specify common arguments to pass to sftp/scp/ssh (e.g.
                        ProxyCommand)
    --sftp-extra-args=SFTP_EXTRA_ARGS
                        specify extra arguments to pass to sftp only (e.g. -f,
                        -l)
    --scp-extra-args=SCP_EXTRA_ARGS
                        specify extra arguments to pass to scp only (e.g. -l)
    --ssh-extra-args=SSH_EXTRA_ARGS
                        specify extra arguments to pass to ssh only (e.g. -R)

Some modules do not make sense in Ad-Hoc (include, meta, etc)
```
