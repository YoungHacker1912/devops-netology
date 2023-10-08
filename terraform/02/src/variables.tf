###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnf13faOhZnWH/LtG7aKKdf95DvTVBRC+/+LCxV16C2WGcpZeLUFVEI4oiFFDBFc8UEcQQ1KUvZZGU28+wbVj6OwDG0ilvqN8RnuSjD2qMWPisd6Gxl+1fRdSdzgY+CO6YnAc9WxgxgEZdawTK3raLHm+65AlQ2yn1KBYsgi8Ob4aL90jwR58t3pmEePWEBeS5yNIr7LXRsIbcV1y5mS0dzuGIM4R3yKHi3KYHTeEeWCKsf5gyzikj3aabmaiU9gz+a7mPsFksdp2JE967KiHyU6KPd0cuN03wMzl0xKC+b/ld6NavMLRtmR4nfLtcbyOif0q+hQp1o21XHvdR7LhvYPO+UCjK1GkmSkZek4dz1Io7sxoBDA/enf1ps9AsyQ1YzPJMVPmuPWdxv3VEsSJR1jV+ppcdCxAcFlw0f9cde8p0h0QxkfyWlGKaPBwbHsNiAC+1zhGCWuyoT0jz/tvM02iAexhRfCYfmHUrH+7ZIt//0xtb8jLt+nlV+5YzA/U= root@anna-VirtualBox"
  description = "ssh-keygen -t ed25519"
}
