## Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).
Решаем задачу для Яндекс.Облака
```
yc iam service-account create --name tfservice --description "Netology terraform service"
yc iam access-key create --service-account-name tfservice --description "key for netology tfservice"
```

Зарегистрируйте бэкэнд в терраформ проекте   
```
~/devops-netology/07-terraform-03-basic$ terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of yandex-cloud/yandex from the dependency lock file
- Using previously-installed yandex-cloud/yandex v0.76.0

Terraform has been successfully initialized!
```
Результат
![s3tfstate.png](s3tfstate.png)

## Задача 2. Инициализируем проект и создаем воркспейсы.
Файл [main.tf](main.tf)

Вывод команды terraform workspace list  
```
~/devops-netology/07-terraform-03-basic$ terraform workspace list
  default
* prod
  stage
```

Вывод команды terraform plan для воркспейса prod
```

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create
[0m
Terraform will perform the following actions:

[1m  # yandex_compute_instance.vms[0][0m will be created[0m[0m
[0m  [32m+[0m[0m resource "yandex_compute_instance" "vms" {
      [32m+[0m [0m[1m[0mcreated_at[0m[0m                = (known after apply)
      [32m+[0m [0m[1m[0mfolder_id[0m[0m                 = (known after apply)
      [32m+[0m [0m[1m[0mfqdn[0m[0m                      = (known after apply)
      [32m+[0m [0m[1m[0mhostname[0m[0m                  = (known after apply)
      [32m+[0m [0m[1m[0mid[0m[0m                        = (known after apply)
      [32m+[0m [0m[1m[0mmetadata[0m[0m                  = {
          [32m+[0m [0m"ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1y...
            EOT
        }
      [32m+[0m [0m[1m[0mname[0m[0m                      = "terraform-0"
      [32m+[0m [0m[1m[0mnetwork_acceleration_type[0m[0m = "standard"
      [32m+[0m [0m[1m[0mplatform_id[0m[0m               = "standard-v1"
      [32m+[0m [0m[1m[0mservice_account_id[0m[0m        = (known after apply)
      [32m+[0m [0m[1m[0mstatus[0m[0m                    = (known after apply)
      [32m+[0m [0m[1m[0mzone[0m[0m                      = (known after apply)

      [32m+[0m [0mboot_disk {
          [32m+[0m [0m[1m[0mauto_delete[0m[0m = true
          [32m+[0m [0m[1m[0mdevice_name[0m[0m = (known after apply)
          [32m+[0m [0m[1m[0mdisk_id[0m[0m     = (known after apply)
          [32m+[0m [0m[1m[0mmode[0m[0m        = (known after apply)

          [32m+[0m [0minitialize_params {
              [32m+[0m [0m[1m[0mblock_size[0m[0m  = (known after apply)
              [32m+[0m [0m[1m[0mdescription[0m[0m = (known after apply)
              [32m+[0m [0m[1m[0mimage_id[0m[0m    = "fd89ovh4ticpo40dkbvd"
              [32m+[0m [0m[1m[0mname[0m[0m        = (known after apply)
              [32m+[0m [0m[1m[0msize[0m[0m        = (known after apply)
              [32m+[0m [0m[1m[0msnapshot_id[0m[0m = (known after apply)
              [32m+[0m [0m[1m[0mtype[0m[0m        = "network-hdd"
            }
        }

      [32m+[0m [0mnetwork_interface {
          [32m+[0m [0m[1m[0mindex[0m[0m              = (known after apply)
          [32m+[0m [0m[1m[0mip_address[0m[0m         = (known after apply)
          [32m+[0m [0m[1m[0mipv4[0m[0m               = true
          [32m+[0m [0m[1m[0mipv6[0m[0m               = (known after apply)
          [32m+[0m [0m[1m[0mipv6_address[0m[0m       = (known after apply)
          [32m+[0m [0m[1m[0mmac_address[0m[0m        = (known after apply)
          [32m+[0m [0m[1m[0mnat[0m[0m                = true
          [32m+[0m [0m[1m[0mnat_ip_address[0m[0m     = (known after apply)
          [32m+[0m [0m[1m[0mnat_ip_version[0m[0m     = (known after apply)
          [32m+[0m [0m[1m[0msecurity_group_ids[0m[0m = (known after apply)
          [32m+[0m [0m[1m[0msubnet_id[0m[0m          = (known after apply)
        }

      [32m+[0m [0mplacement_policy {
          [32m+[0m [0m[1m[0mhost_affinity_rules[0m[0m = (known after apply)
          [32m+[0m [0m[1m[0mplacement_group_id[0m[0m  = (known after apply)
        }

      [32m+[0m [0mresources {
          [32m+[0m [0m[1m[0mcore_fraction[0m[0m = 100
          [32m+[0m [0m[1m[0mcores[0m[0m         = 4
          [32m+[0m [0m[1m[0mmemory[0m[0m        = 4
        }

      [32m+[0m [0mscheduling_policy {
          [32m+[0m [0m[1m[0mpreemptible[0m[0m = (known after apply)
        }
    }

[1m  # yandex_compute_instance.vms[1][0m will be created[0m[0m
[0m  [32m+[0m[0m resource "yandex_compute_instance" "vms" {
      [32m+[0m [0m[1m[0mcreated_at[0m[0m                = (known after apply)
      [32m+[0m [0m[1m[0mfolder_id[0m[0m                 = (known after apply)
      [32m+[0m [0m[1m[0mfqdn[0m[0m                      = (known after apply)
      [32m+[0m [0m[1m[0mhostname[0m[0m                  = (known after apply)
      [32m+[0m [0m[1m[0mid[0m[0m                        = (known after apply)
      [32m+[0m [0m[1m[0mmetadata[0m[0m                  = {
          [32m+[0m [0m"ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1y...
            EOT
        }
      [32m+[0m [0m[1m[0mname[0m[0m                      = "terraform-1"
      [32m+[0m [0m[1m[0mnetwork_acceleration_type[0m[0m = "standard"
      [32m+[0m [0m[1m[0mplatform_id[0m[0m               = "standard-v1"
      [32m+[0m [0m[1m[0mservice_account_id[0m[0m        = (known after apply)
      [32m+[0m [0m[1m[0mstatus[0m[0m                    = (known after apply)
      [32m+[0m [0m[1m[0mzone[0m[0m                      = (known after apply)

      [32m+[0m [0mboot_disk {
          [32m+[0m [0m[1m[0mauto_delete[0m[0m = true
          [32m+[0m [0m[1m[0mdevice_name[0m[0m = (known after apply)
          [32m+[0m [0m[1m[0mdisk_id[0m[0m     = (known after apply)
          [32m+[0m [0m[1m[0mmode[0m[0m        = (known after apply)

          [32m+[0m [0minitialize_params {
              [32m+[0m [0m[1m[0mblock_size[0m[0m  = (known after apply)
              [32m+[0m [0m[1m[0mdescription[0m[0m = (known after apply)
              [32m+[0m [0m[1m[0mimage_id[0m[0m    = "fd89ovh4ticpo40dkbvd"
              [32m+[0m [0m[1m[0mname[0m[0m        = (known after apply)
              [32m+[0m [0m[1m[0msize[0m[0m        = (known after apply)
              [32m+[0m [0m[1m[0msnapshot_id[0m[0m = (known after apply)
              [32m+[0m [0m[1m[0mtype[0m[0m        = "network-hdd"
            }
        }

      [32m+[0m [0mnetwork_interface {
          [32m+[0m [0m[1m[0mindex[0m[0m              = (known after apply)
          [32m+[0m [0m[1m[0mip_address[0m[0m         = (known after apply)
          [32m+[0m [0m[1m[0mipv4[0m[0m               = true
          [32m+[0m [0m[1m[0mipv6[0m[0m               = (known after apply)
          [32m+[0m [0m[1m[0mipv6_address[0m[0m       = (known after apply)
          [32m+[0m [0m[1m[0mmac_address[0m[0m        = (known after apply)
          [32m+[0m [0m[1m[0mnat[0m[0m                = true
          [32m+[0m [0m[1m[0mnat_ip_address[0m[0m     = (known after apply)
          [32m+[0m [0m[1m[0mnat_ip_version[0m[0m     = (known after apply)
          [32m+[0m [0m[1m[0msecurity_group_ids[0m[0m = (known after apply)
          [32m+[0m [0m[1m[0msubnet_id[0m[0m          = (known after apply)
        }

      [32m+[0m [0mplacement_policy {
          [32m+[0m [0m[1m[0mhost_affinity_rules[0m[0m = (known after apply)
          [32m+[0m [0m[1m[0mplacement_group_id[0m[0m  = (known after apply)
        }

      [32m+[0m [0mresources {
          [32m+[0m [0m[1m[0mcore_fraction[0m[0m = 100
          [32m+[0m [0m[1m[0mcores[0m[0m         = 4
          [32m+[0m [0m[1m[0mmemory[0m[0m        = 4
        }

      [32m+[0m [0mscheduling_policy {
          [32m+[0m [0m[1m[0mpreemptible[0m[0m = (known after apply)
        }
    }

[1m  # yandex_compute_instance.vms-2["instance-1"][0m will be created[0m[0m
[0m  [32m+[0m[0m resource "yandex_compute_instance" "vms-2" {
      [32m+[0m [0m[1m[0mcreated_at[0m[0m                = (known after apply)
      [32m+[0m [0m[1m[0mfolder_id[0m[0m                 = (known after apply)
      [32m+[0m [0m[1m[0mfqdn[0m[0m                      = (known after apply)
      [32m+[0m [0m[1m[0mhostname[0m[0m                  = (known after apply)
      [32m+[0m [0m[1m[0mid[0m[0m                        = (known after apply)
      [32m+[0m [0m[1m[0mmetadata[0m[0m                  = {
          [32m+[0m [0m"ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1y...
            EOT
        }
      [32m+[0m [0m[1m[0mname[0m[0m                      = "instance-1"
      [32m+[0m [0m[1m[0mnetwork_acceleration_type[0m[0m = "standard"
      [32m+[0m [0m[1m[0mplatform_id[0m[0m               = "standard-v1"
      [32m+[0m [0m[1m[0mservice_account_id[0m[0m        = (known after apply)
      [32m+[0m [0m[1m[0mstatus[0m[0m                    = (known after apply)
      [32m+[0m [0m[1m[0mzone[0m[0m                      = (known after apply)

      [32m+[0m [0mboot_disk {
          [32m+[0m [0m[1m[0mauto_delete[0m[0m = true
          [32m+[0m [0m[1m[0mdevice_name[0m[0m = (known after apply)
          [32m+[0m [0m[1m[0mdisk_id[0m[0m     = (known after apply)
          [32m+[0m [0m[1m[0mmode[0m[0m        = (known after apply)

          [32m+[0m [0minitialize_params {
              [32m+[0m [0m[1m[0mblock_size[0m[0m  = (known after apply)
              [32m+[0m [0m[1m[0mdescription[0m[0m = (known after apply)
              [32m+[0m [0m[1m[0mimage_id[0m[0m    = "fd89ovh4ticpo40dkbvd"
              [32m+[0m [0m[1m[0mname[0m[0m        = (known after apply)
              [32m+[0m [0m[1m[0msize[0m[0m        = (known after apply)
              [32m+[0m [0m[1m[0msnapshot_id[0m[0m = (known after apply)
              [32m+[0m [0m[1m[0mtype[0m[0m        = "network-hdd"
            }
        }

      [32m+[0m [0mnetwork_interface {
          [32m+[0m [0m[1m[0mindex[0m[0m              = (known after apply)
          [32m+[0m [0m[1m[0mip_address[0m[0m         = (known after apply)
          [32m+[0m [0m[1m[0mipv4[0m[0m               = true
          [32m+[0m [0m[1m[0mipv6[0m[0m               = (known after apply)
          [32m+[0m [0m[1m[0mipv6_address[0m[0m       = (known after apply)
          [32m+[0m [0m[1m[0mmac_address[0m[0m        = (known after apply)
          [32m+[0m [0m[1m[0mnat[0m[0m                = true
          [32m+[0m [0m[1m[0mnat_ip_address[0m[0m     = (known after apply)
          [32m+[0m [0m[1m[0mnat_ip_version[0m[0m     = (known after apply)
          [32m+[0m [0m[1m[0msecurity_group_ids[0m[0m = (known after apply)
          [32m+[0m [0m[1m[0msubnet_id[0m[0m          = (known after apply)
        }

      [32m+[0m [0mplacement_policy {
          [32m+[0m [0m[1m[0mhost_affinity_rules[0m[0m = (known after apply)
          [32m+[0m [0m[1m[0mplacement_group_id[0m[0m  = (known after apply)
        }

      [32m+[0m [0mresources {
          [32m+[0m [0m[1m[0mcore_fraction[0m[0m = 100
          [32m+[0m [0m[1m[0mcores[0m[0m         = 2
          [32m+[0m [0m[1m[0mmemory[0m[0m        = 2
        }

      [32m+[0m [0mscheduling_policy {
          [32m+[0m [0m[1m[0mpreemptible[0m[0m = (known after apply)
        }
    }

[1m  # yandex_compute_instance.vms-2["instance-2"][0m will be created[0m[0m
[0m  [32m+[0m[0m resource "yandex_compute_instance" "vms-2" {
      [32m+[0m [0m[1m[0mcreated_at[0m[0m                = (known after apply)
      [32m+[0m [0m[1m[0mfolder_id[0m[0m                 = (known after apply)
      [32m+[0m [0m[1m[0mfqdn[0m[0m                      = (known after apply)
      [32m+[0m [0m[1m[0mhostname[0m[0m                  = (known after apply)
      [32m+[0m [0m[1m[0mid[0m[0m                        = (known after apply)
      [32m+[0m [0m[1m[0mmetadata[0m[0m                  = {
          [32m+[0m [0m"ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1y...
            EOT
        }
      [32m+[0m [0m[1m[0mname[0m[0m                      = "instance-2"
      [32m+[0m [0m[1m[0mnetwork_acceleration_type[0m[0m = "standard"
      [32m+[0m [0m[1m[0mplatform_id[0m[0m               = "standard-v1"
      [32m+[0m [0m[1m[0mservice_account_id[0m[0m        = (known after apply)
      [32m+[0m [0m[1m[0mstatus[0m[0m                    = (known after apply)
      [32m+[0m [0m[1m[0mzone[0m[0m                      = (known after apply)

      [32m+[0m [0mboot_disk {
          [32m+[0m [0m[1m[0mauto_delete[0m[0m = true
          [32m+[0m [0m[1m[0mdevice_name[0m[0m = (known after apply)
          [32m+[0m [0m[1m[0mdisk_id[0m[0m     = (known after apply)
          [32m+[0m [0m[1m[0mmode[0m[0m        = (known after apply)

          [32m+[0m [0minitialize_params {
              [32m+[0m [0m[1m[0mblock_size[0m[0m  = (known after apply)
              [32m+[0m [0m[1m[0mdescription[0m[0m = (known after apply)
              [32m+[0m [0m[1m[0mimage_id[0m[0m    = "fd89ovh4ticpo40dkbvd"
              [32m+[0m [0m[1m[0mname[0m[0m        = (known after apply)
              [32m+[0m [0m[1m[0msize[0m[0m        = (known after apply)
              [32m+[0m [0m[1m[0msnapshot_id[0m[0m = (known after apply)
              [32m+[0m [0m[1m[0mtype[0m[0m        = "network-hdd"
            }
        }

      [32m+[0m [0mnetwork_interface {
          [32m+[0m [0m[1m[0mindex[0m[0m              = (known after apply)
          [32m+[0m [0m[1m[0mip_address[0m[0m         = (known after apply)
          [32m+[0m [0m[1m[0mipv4[0m[0m               = true
          [32m+[0m [0m[1m[0mipv6[0m[0m               = (known after apply)
          [32m+[0m [0m[1m[0mipv6_address[0m[0m       = (known after apply)
          [32m+[0m [0m[1m[0mmac_address[0m[0m        = (known after apply)
          [32m+[0m [0m[1m[0mnat[0m[0m                = true
          [32m+[0m [0m[1m[0mnat_ip_address[0m[0m     = (known after apply)
          [32m+[0m [0m[1m[0mnat_ip_version[0m[0m     = (known after apply)
          [32m+[0m [0m[1m[0msecurity_group_ids[0m[0m = (known after apply)
          [32m+[0m [0m[1m[0msubnet_id[0m[0m          = (known after apply)
        }

      [32m+[0m [0mplacement_policy {
          [32m+[0m [0m[1m[0mhost_affinity_rules[0m[0m = (known after apply)
          [32m+[0m [0m[1m[0mplacement_group_id[0m[0m  = (known after apply)
        }

      [32m+[0m [0mresources {
          [32m+[0m [0m[1m[0mcore_fraction[0m[0m = 100
          [32m+[0m [0m[1m[0mcores[0m[0m         = 4
          [32m+[0m [0m[1m[0mmemory[0m[0m        = 4
        }

      [32m+[0m [0mscheduling_policy {
          [32m+[0m [0m[1m[0mpreemptible[0m[0m = (known after apply)
        }
    }

[1m  # yandex_vpc_network.network-1[0m will be created[0m[0m
[0m  [32m+[0m[0m resource "yandex_vpc_network" "network-1" {
      [32m+[0m [0m[1m[0mcreated_at[0m[0m                = (known after apply)
      [32m+[0m [0m[1m[0mdefault_security_group_id[0m[0m = (known after apply)
      [32m+[0m [0m[1m[0mfolder_id[0m[0m                 = (known after apply)
      [32m+[0m [0m[1m[0mid[0m[0m                        = (known after apply)
      [32m+[0m [0m[1m[0mlabels[0m[0m                    = (known after apply)
      [32m+[0m [0m[1m[0mname[0m[0m                      = "network1"
      [32m+[0m [0m[1m[0msubnet_ids[0m[0m                = (known after apply)
    }

[1m  # yandex_vpc_subnet.subnet-1[0m will be created[0m[0m
[0m  [32m+[0m[0m resource "yandex_vpc_subnet" "subnet-1" {
      [32m+[0m [0m[1m[0mcreated_at[0m[0m     = (known after apply)
      [32m+[0m [0m[1m[0mfolder_id[0m[0m      = (known after apply)
      [32m+[0m [0m[1m[0mid[0m[0m             = (known after apply)
      [32m+[0m [0m[1m[0mlabels[0m[0m         = (known after apply)
      [32m+[0m [0m[1m[0mname[0m[0m           = "subnet1"
      [32m+[0m [0m[1m[0mnetwork_id[0m[0m     = (known after apply)
      [32m+[0m [0m[1m[0mv4_cidr_blocks[0m[0m = [
          [32m+[0m [0m"192.168.10.0/24",
        ]
      [32m+[0m [0m[1m[0mv6_cidr_blocks[0m[0m = (known after apply)
      [32m+[0m [0m[1m[0mzone[0m[0m           = "ru-central1-a"
    }

[0m[1mPlan:[0m 6 to add, 0 to change, 0 to destroy.
[0m[90m
─────────────────────────────────────────────────────────────────────────────[0m

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.

```