# About This Repo
This repository creates basic infrastructure on Azure for the purpose of installing Hashicorp Consul on Virtual Machines (VM).

More specifically it creates:
- A Resource Group (RG)
- A Virtual Network (VNET) with a subnet
- Network Security Groups (NSG) with rules based on Hashicorp Consul requirements
- A number of VMs to allow Consul Servers, Clients, and Mesh Gateways to be installed on
- IP addresses and network interfaces based on the settings defined
- A Storage Account for Consul Snapshots to be placed in


