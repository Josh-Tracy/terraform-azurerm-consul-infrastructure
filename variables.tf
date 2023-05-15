variable "friendly_name_prefix" {
  type        = string
  description = "A prefix appended to the name of azure resources."

  validation {
    condition     = can(regex("^[[:alnum:]]+$", var.friendly_name_prefix)) && length(var.friendly_name_prefix) < 13
    error_message = "Must only contain alphanumeric characters and be less than 13 characters."
  }
}

variable "common_tags" {
  type        = map(string)
  description = "Map of common tags for taggable Azure resources."
  default     = {}
}

variable "primary_consul_rg" {
  type        = string
  description = "The primary consul cluster resource group name."
  default     = "primary-consul-rg"
}

variable "primary_consul_rg_location" {
  type        = string
  description = "The location of the primary consul cluster resource group."
  default     = "East US"
}

#-------------------------------------------------------------------------
# Storage Account
#-------------------------------------------------------------------------
variable "sa_ingress_cidr_allow" {
  type        = list(string)
  description = "List of CIDRs allowed to interact with Azure Blob Storage Account."
  default     = []
}

#-------------------------------------------------------------------------
# VNet
#-------------------------------------------------------------------------
variable "vnet_cidr" {
  type        = list(string)
  description = "CIDR block address space for VNet."
  default     = ["10.0.0.0/16"]
}

variable "consul_subnet_cidr" {
  type        = string
  description = "CIDR block for Consul subnet1."
  default     = "10.0.1.0/24"
}

variable "bastion_subnet_cidr" {
  type        = string
  description = "CIDR block for Consul subnet2."
  default     = "10.0.2.0/24"
}

variable "create_nat_gateway" {
  type        = bool
  description = "Boolean to create a NAT Gateway. Useful when Azure Load Balancer is internal but VM(s) require outbound Internet access."
  default     = false
}

variable "bastion_ingress_cidr_allow" {
  type        = list(string)
  description = "List of CIDRs allowed inbound to bastion via SSH (port 22) on bastion subnet."
  default     = []
}
#-------------------------------------------------------------------------
# VM
#-------------------------------------------------------------------------
variable "deploy_virtual_machines" {
  type        = bool
  description = "Set to true to deploy virtual machines."
  default     = false
}

variable "consul_ingress_cidr_allow" {
  type        = list(string)
  description = "List of CIDRs allowed inbound to consul servers via SSH (port 22) on vnet."
  default     = []
}

variable "vm_settings" {
  type        = map(any)
  description = "Map of the zones to put the VMs into."
  default = {
    consul-vm-1-server = {
      zone = "1"
    }
    consul-vm-2-server = {
      zone = "1"
    }
    consul-vm-3-server = {
      zone = "2"
    }
    consul-vm-4-server = {
      zone = "2"
    }
    consul-vm-5-server = {
      zone = "3"
    }
    consul-vm-6-server = {
      zone = "3"
    }
    consul-vm-7-client = {
      zone = "1"
    }
    consul-vm-8-client = {
      zone = "2"
    }
  }
}