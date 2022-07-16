## Задача 1 (Вариант с Yandex.Cloud). Регистрация в ЯО и знакомство с основами (необязательно, но крайне желательно).
Аккант в Яндекс.Облаке мы моздали ранее продолжим работать в нём.  
4. Создадим переменную окружения 'YC_TOKEN' и инициализируем её

## Задача 2. Создание aws ec2 или yandex_compute_instance через терраформ.
1. В каталоге terraform вашего основного репозитория, который был создан в начале курсе, создайте файл main.tf и versions.tf.
```
~/devops-netology/terraform$ ls -l
total 4
-rw-r--r-- 1 laykomdn laykomdn 282 Jul 16 09:54 main.tf
-rw-r--r-- 1 laykomdn laykomdn   0 Jul 16 09:39 versions.tf
```
2. Зарегистрируйте провайдер
```
~/devops-netology/terraform$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of yandex-cloud/yandex...
- Installing yandex-cloud/yandex v0.76.0...
- Installed yandex-cloud/yandex v0.76.0 (unauthenticated)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

4. Выполним поиск доступных образов виртуальных машин с ОС Ubuntu
```
~/devops-netology/terraform$ yc compute image list --folder-id standard-images | grep ubuntu-20

| fd8fbgvdt6mktnprvo89 | ubuntu-20-04-lts-v20210811a                                    | ubuntu-2004-lts                                 | f2er2cc89e252lj4bf5o           | READY  |
| fd8fh5he9b41fm3uuj1b | ubuntu-20-04-lts-gpu-a100-v20220606                            | ubuntu-2004-lts-a100                            | f2ehvtaktpen71lf32gh           | READY  |
| fd8firhksp7daa6msfes | ubuntu-20-04-lts-v20210929                                     | ubuntu-2004-lts                                 | f2e6fnj3erf1sropamjr           | READY  |
| fd8fte6bebi857ortlja | ubuntu-20-04-lts-v20211227                                     | ubuntu-2004-lts                                 | f2eh8sclblvdlq7iarqv           | READY  |
| fd8g27r7sr6ljtjpkv44 | ubuntu-20-04-lts-gpu-v20220124                                 | ubuntu-2004-lts-gpu                             | f2eclm7ngjuv43o8mqqg           | READY  |
```

5. В файле main.tf создайте рессурс yandex_compute_image
Прикладываю файл [main.tf](main.tf)  
Результат [tfapply.png](tfapply.png)

## Ответ на вопрос: при помощи какого инструмента (из разобранных на прошлом занятии) можно создать свой образ ami?
Свой образ ami можно собрать при помощи Packer

