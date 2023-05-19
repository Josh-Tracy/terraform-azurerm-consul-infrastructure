# About This Repo
This Terraform module creates basic infrastructure on Azure for the purpose of installing Hashicorp Consul on Virtual Machines (VM).

More specifically it creates:
- A Resource Group (RG)
- A Virtual Network (VNET) with a subnet and a NAT Gateway
- Network Security Groups (NSG) with rules based on Hashicorp Consul requirements
- A number of VMs to allow Consul Servers, Clients, and Mesh Gateways to be installed on
- Public IP addresses and network interfaces
- A Storage Account for Consul Snapshots to be placed in

## How to Use
- Check if the Azure region you're trying to deploy in supports availability zones https://learn.microsoft.com/en-us/azure/reliability/availability-zones-service-support

In the `examples` directory of this repository are examples using this module.

### Single Consul Datacenter
Call the module once:

```
module "consul-dc-1" {
  source = "../.."

  friendly_name_prefix = "devdc1"
  consul_rg            = "consul-dc1"
  consul_rg_location   = "East US"
  common_tags = {
    "App"         = "Consul"
    "Owner"       = "admin@company.com"
    "Terraform"   = "cli"
    "Environment" = "dev"
    "Consul-DC"   = "dc1"
  }

  sa_ingress_cidr_allow      = ["1.2.3.4"]
  bastion_ingress_cidr_allow = ["1.2.3.4/32"]
  consul_ingress_cidr_allow  = ["1.2.3.4/32"]

  vnet_cidr           = ["10.0.0.0/16"]
  consul_subnet_cidr  = "10.0.1.0/24"
  bastion_subnet_cidr = "10.0.2.0/24"

  deploy_virtual_machines = true
  ssh_public_key          = "consul.pub"
  vm_admin_username       = "consuladmin"

  vm_settings = {
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
    consul-vm-9-mesh-gw-dc1 = {
      zone = "1"
    }
  }
}

output "consul-dc-1-private-instance-ip" {
  value = module.consul-dc-1.privatE_instance_ip_addr
}

output "consul-dc-1-public-instance-ip" {
  value = module.consul-dc-1.public_instance_ip_addr
}

```

### Multiple Consul Datacenters
Call the module as many times as needed to create a number of different datacenters in different regions:

```
module "consul-dc-1" {
  source = "../.."

  friendly_name_prefix = "devdc1"
  consul_rg            = "consul-dc1"
  consul_rg_location   = "East US"

  ... rest of code

module "consul-dc-2" {
  source = "../.."

  friendly_name_prefix = "devdc2"
  consul_rg            = "consul-dc2"
  consul_rg_location   = "West US 2"

  ... rest of code

output "consul-dc-1-private-instance-ip" {
  value = module.consul-dc-1.privatE_instance_ip_addr
}

output "consul-dc-1-public-instance-ip" {
  value = module.consul-dc-1.public_instance_ip_addr
}

output "consul-dc-2-private-instance-ip" {
  value = module.consul-dc-2.privatE_instance_ip_addr
}

output "consul-dc-2-public-instance-ip" {
  value = module.consul-dc-2.public_instance_ip_addr
}
```


