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

variable "consul_rg" {
  type        = string
  description = "The primary consul cluster resource group name."
  default     = "consul-rg"
}

variable "consul_rg_location" {
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

variable "create_nat_gateway" {
  type        = bool
  description = "Boolean to create a NAT Gateway. Useful when Azure Load Balancer is internal but VM(s) require outbound Internet access."
  default     = false
}

variable "consul_ingress_cidr_allow" {
  type        = list(string)
  description = "List of CIDRs allowed inbound to consul servers via SSH (port 22) on vnet."
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

variable "vm_admin_username" {
  type        = string
  description = "The username of the admin user that will be created on the VM. Will also be set to the SSH username."
  default     = "consuladmin"
}

variable "ssh_public_key" {
  type        = string
  description = "The name of the ssh public key that will be put on the VMs. Must be placed relative to the working directory."
}

variable "vm_settings" {
  type        = map(any)
  description = "Map of VMs to create and what zones to put them in. The key will be the servr name."
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
    consul-vm-9-mesh-gw = {
      zone = "1"
    }
  }
}