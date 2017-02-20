# Configure VMware vSphere provider
provider "vsphere" {
  user = "${var.vsphere_user}"
  password = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"
  allow_unverified_ssl = "true"
  }

#Create a folder
resource "vsphere_folder" "test" {
  path = "VirtualMachines"
  datacenter = "vBlock"
  }

#Create RedHat Virtual Machines
resource "vsphere_virtual_machine" "RedHat"{
  name = "RedHat-${format("%03d", count.index+1)}"
  datacenter = "vBlock"
  cluster = "vBlock_FRA-A1"
  folder = "${vsphere_folder.test.path}"
  vcpu = "2"
  memory = "8192"
  network_interface {
    label = "(2021) DE-FRA-AVC-Interim"       
    }
  disk {
    # For VMware Storage Cluster the complete path to a datastore has to be declared "StorageCluster-Name/datastore-Name"
    datastore = "vBlock_FRA-A1_RDS/vBlock_FRA-A1_RDS_000"
    template = "RH7-template"
    }
  count = "1"
  }
