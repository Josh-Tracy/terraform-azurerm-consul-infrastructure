# An example of calling the module twice to create 2 Consul datacenters in seperate regions

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

  sa_ingress_cidr_allow     = ["1.1.1.1"]
  consul_ingress_cidr_allow = ["1.1.1.1/32"]

  vnet_cidr          = ["10.0.0.0/16"]
  consul_subnet_cidr = "10.0.1.0/24"

  # Deploys VMs so you can test configuring static VMs using Ansible or some other tool
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


module "consul-dc-2" {
  source = "../.."

  friendly_name_prefix = "devdc2"
  consul_rg            = "consul-dc2"
  consul_rg_location   = "West US 2"
  common_tags = {
    "App"         = "Consul"
    "Owner"       = "admin@company.com"
    "Terraform"   = "cli"
    "Environment" = "dev"
    "Consul-DC"   = "dc2"
  }

  sa_ingress_cidr_allow     = ["1.1.1.1"]
  consul_ingress_cidr_allow = ["1.1.1.1/32"]

  vnet_cidr          = ["10.0.0.0/16"]
  consul_subnet_cidr = "10.0.1.0/24"

  # Deploys VMs so you can test configuring static VMs using Ansible or some other tool
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
    consul-vm-9-mesh-gw-dc2 = {
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

output "consul-dc-2-private-instance-ip" {
  value = module.consul-dc-2.privatE_instance_ip_addr
}

output "consul-dc-2-public-instance-ip" {
  value = module.consul-dc-2.public_instance_ip_addr
}