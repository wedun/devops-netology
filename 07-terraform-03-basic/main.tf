provider "yandex" {
  cloud_id  = "b1gfmggr757ala32rq97"
  folder_id = "b1g79ptugpleeoj44c6k"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vms" {
  name  = "terraform-${count.index}"
  count = local.workspace_inst_count[terraform.workspace]

  resources {
    cores  = local.vm-1_cores[terraform.workspace]
    memory = local.vm-1_memory[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "fd89ovh4ticpo40dkbvd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "vms-2" {
  for_each = local.instance_names
  name  = each.key

  resources {
    cores  = each.value
    memory = each.value
  }

  boot_disk {
    initialize_params {
      image_id = "fd89ovh4ticpo40dkbvd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  lifecycle {
    create_before_destroy = true
   }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

locals {
  vm-1_cores  = {
    stage = 2
    prod  = 4
  }

  vm-1_memory = {
    stage = 2
    prod  = 4
  }

  workspace_inst_count  = {
    stage = 1
    prod  = 2
  }

  instance_names = {
    "instance-1" = 2
    "instance-2" = 4
  }
}