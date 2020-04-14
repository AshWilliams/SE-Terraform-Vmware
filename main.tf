##### Provider
provider "vsphere" {
  user           = var.provider_vsphere_user
  password       = var.provider_vsphere_password
  vsphere_server = var.provider_vsphere_host

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

##### Data sources
data "vsphere_datacenter" "target_dc" {
  name = var.deploy_vsphere_datacenter
}

data "vsphere_datastore" "target_datastore" {
  name          = var.deploy_vsphere_datastore
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_compute_cluster" "target_cluster" {
  name          = var.deploy_vsphere_cluster
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_network" "target_network" {
  name          = var.deploy_vsphere_network
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_virtual_machine" "source_template" {
  name          = var.guest_template
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

##### Resources
# Windows Center VM 
resource "vsphere_virtual_machine" "winvm" {
  name             = "prod-win-server01"
  resource_pool_id = data.vsphere_compute_cluster.target_cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.target_datastore.id

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = data.vsphere_virtual_machine.source_template.guest_id

  network_interface {
    network_id   = data.vsphere_network.target_network.id
    adapter_type = data.vsphere_virtual_machine.source_template.network_interface_types[0]
  }

  disk {
    label = "disk0"
    size  = 20
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.source_template.id
    linked_clone  = var.linked_clone
    timeout       = var.timeout

    customize {
      windows_options {
        computer_name         = "WinServerSE01"
        admin_password        = var.local_adminpass
        workgroup             = var.workgroup
        join_domain           = var.windomain
        domain_admin_user     = var.domain_admin_user
        domain_admin_password = var.domain_admin_password
        organization_name     = var.orgname
        run_once_command_list = var.run_once
        auto_logon            = var.auto_logon
        auto_logon_count      = var.auto_logon_count
        time_zone             = var.time_zone
        product_key           = var.productkey
        full_name             = var.full_name
      }

      dns_server_list = var.vmdns
      dns_suffix_list = var.dns_suffix_list
      ipv4_gateway    = var.vmgateway
    }
  }
}

