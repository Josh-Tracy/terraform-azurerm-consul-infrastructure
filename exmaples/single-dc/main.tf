module "consul-dc-1" {
  source = "../.."

  friendly_name_prefix = "jtracy"
  consul_rg            = "consul-dc1"
  consul_rg_location   = "East US"
  common_tags = {
    "App"         = "Consul"
    "Owner"       = "joshua.tracy@hashicorp.com"
    "Terraform"   = "cli"
    "Environment" = "dev"
    "Consul-DC"   = "dc1"
  }

  sa_ingress_cidr_allow      = ["96.59.96.145"]
  bastion_ingress_cidr_allow = ["96.59.96.145/32"]
  consul_ingress_cidr_allow  = ["96.59.96.145/32"]

  vnet_cidr           = ["10.0.0.0/16"]
  consul_subnet_cidr  = "10.0.1.0/24"
  bastion_subnet_cidr = "10.0.2.0/24"

  # Deploys VMs so you can test configuring static VMs using Ansible or some other tool
  deploy_virtual_machines = true
  ssh_public_key = "consul.pub"
  vm_admin_username = "consuladmin"
}