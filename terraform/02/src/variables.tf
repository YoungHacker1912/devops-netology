###cloud vars

variable "vm_web_resources" {
    type = map
    default = {
        cores  = 2
        memory = 1
        core_fraction = 5
    }
}

variable "vm_db_resources" {
    type = map
    default = {
        cores  = 2
        memory = 2
        core_fraction = 20
    }
}


variable "vms_metadata" {
    type = map
    default = {
        serial-port-enable = 1
        ssh-keys = "***"
    }
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
}

variable "platform"   {
  type        = string
  default     = "netology"
}

variable "env"   {
  type        = string
  default     = "develop"
}

variable "project"   {
  type        = string
  default     = "platform"
}

variable "role"   {
  type        = string
  default     = "web"
}

variable "role2"   {
  type        = string
  default     = "db"
}

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
}

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
