##### Guest
# - Describes virtual machine / guest options
variable "provider_vsphere_host" {
  description = "vCenter server FQDN or IP - Example: vcsa01-z67.sddc.lab"
}

variable "provider_vsphere_user" {
  description = "vSphere username to use to connect to the environment - Default: administrator@vsphere.local"
  default     = "administrator@vsphere.local"
}

variable "provider_vsphere_password" {
  description = "vSphere password"
}

##### Infrastructure
# - Defines the vCenter / vSphere environment

variable "deploy_vsphere_datacenter" {
  description = "vSphere datacenter in which the virtual machine will be deployed."
}

variable "deploy_vsphere_cluster" {
  description = "vSphere cluster in which the virtual machine will be deployed."
}

variable "deploy_vsphere_datastore" {
  description = "Datastore in which the virtual machine will be deployed."
}

variable "deploy_vsphere_folder" {
  description = "The path to the folder to put this virtual machine in, relative to the datacenter that the resource pool is in."
}

variable "deploy_vsphere_network" {
  description = "Porgroup to which the virtual machine will be connected."
}

##### Guest
# - Describes virtual machine / guest options

variable "guest_template" {
  description = "The source virtual machine or template to clone from."
}

variable "guest_vcpu" {
  description = "The number of virtual processors to assign to this virtual machine. Default: 1."
  default     = "1"
}

variable "guest_memory" {
  description = "The size of the virtual machine's memory, in MB. Default: 1024 (1 GB)."
  default     = "1024"
}

variable "guest_ipv4_netmask" {
  description = "The IPv4 subnet mask, in bits (example: 24 for 255.255.255.0)."
}

variable "guest_ipv4_gateway" {
  description = "The IPv4 default gateway."
}

variable "guest_dns_servers" {
  description = "The list of DNS servers to configure on the virtual machine."
}

variable "guest_dns_suffix" {
  description = "A list of DNS search domains to add to the DNS configuration on the virtual machine."
}

variable "guest_domain" {
  description = "The domain name for this machine."
}

# Windows 

variable "linked_clone" {
  description = "Clone this virtual machine from a snapshot. Templates must have a single snapshot only in order to be eligible."
  default     = false
}

variable "timeout" {
  description = "The timeout, in minutes, to wait for the virtual machine clone to complete."
  type        = number
  default     = 30
}

variable "local_adminpass" {
  description = "The administrator password for this virtual machine.(Required) when using join_windomain option"
  default     = null
}

variable "workgroup" {
  description = "The workgroup name for this virtual machine. One of this or join_domain must be included."
  default     = null
}

variable "windomain" {
  description = "The domain to join for this virtual machine. One of this or workgroup must be included."
  default     = null
}

variable "domain_admin_user" {
  description = "Domain admin user to join the server to AD.(Required) when using join_windomain option"
  default     = null
}

variable "domain_admin_password" {
  description = "Doamin User pssword to join the server to AD.(Required) when using join_windomain option"
  default     = null
}

variable "orgname" {
  description = "Organization name for when joining windows server to AD"
  default     = null
}

variable "auto_logon" {
  description = " Specifies whether or not the VM automatically logs on as Administrator. Default: false"
  default     = null
}

variable "auto_logon_count" {
  description = "Specifies how many times the VM should auto-logon the Administrator account when auto_logon is true. This should be set accordingly to ensure that all of your commands that run in run_once_command_list can log in to run"
  default     = null
}

variable "time_zone" {
  description = "The new time zone for the virtual machine. This is a numeric, sysprep-dictated, timezone code."
  default     = null
}

variable "run_once" {
  description = "List of Comamnd to run during first logon (Automatic login set to 1)"
  type        = list(string)
  default     = null
}

variable "productkey" {
  description = "Product key to be used during windows customization."
  default     = null
}

variable "full_name" {
  description = "The full name of the user of this virtual machine. This populates the user field in the general Windows system information. Default - Administrator"
  default     = null
}

variable "vmdns" {
  type    = list(string)
  default = null
}

variable "dns_suffix_list" {
  description = "A list of DNS search domains to add to the DNS configuration on the virtual machine."
  type        = list(string)
  default     = null
}

variable "vmgateway" {
  description = "VM gateway to set during provisioning"
  default     = null
}