variable TF_VAR_enviroment{default="staging" }
variable "location" {
  type    = string
  default = "eastus"
}

variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "acr_name" {
  type        = string
  description = "Registry name"
  default= "weightappacr"
}

variable "rg_name" {
  type        = string
  description = "Resource group name"
  default= "weightapp"
}

variable "dns_prefix" {
  type        = string
  description = "dns_prefix"
  default     = "weightdns"
}

variable "agent_count" {
  description = "agent_count"
  default     = 1
}

variable "env" {
  type        = string
  description = "Environment name"
  default = "dev"
}

variable "enviroment" {
  type        = string
  description = "Environment name"
  default = "staging"
}
