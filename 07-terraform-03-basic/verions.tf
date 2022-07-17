terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoint    = "storage.yandexcloud.net"
    bucket      = "netology-tf-s3"
    region      = "ru-central1"
    key         = "remote-state/terraform.tfstate"
    access_key  = "YCAJE4MlFVq_VRMJrhD1A1GIA"
    secret_key  = "YCPSgzVNfvYSmQ7ylTRXPuUF3tVoZnHQ_37rdAXW"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
