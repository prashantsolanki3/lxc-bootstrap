# module "lxc-module" {
#   source       = "prashantsolanki3/lxc-module/proxmox"
#   version      = "0.0.3"
#   target_node  = var.target_node
#   # General Config
#   unprivileged = var.unprivileged
#   hostname = var.hostname
#   description  = var.description
#   template     = var.template
#   ostype       = var.ostype
#   cpu_count    = var.cpu_count
#   memory        = var.memory
#   disk_size = var.disk_size
#   disk_storage = var.disk_storage
#   public_key_file = var.public_key_file

#   # Network Config
#   ipv4_gateway = var.ipv4_gateway
#   ipv4         = var.ipv4
#   ipv4_data    = var.ipv4_data

# }



resource "proxmox_lxc" "container" {

  target_node  = var.target_node
  hostname     = var.hostname
  ostemplate   = var.template
  unprivileged = var.unprivileged
  ostype       = var.ostype
  cores       = var.cpu_count
  description = var.description
  memory      = var.memory
  start       = true


  ssh_public_keys = <<EOF
  ${file(var.public_key_file)}
  EOF

  features {
    fuse    = true
    nesting = true
    mount   = "nfs;cifs"
  }

  // Terraform will crash without rootfs defined
  rootfs {
    storage = var.disk_storage
    size    = var.disk_size
  }

  // Bind Mount Point
  mountpoint {
    key     = "1"
    slot    = 1
    storage = "/slow-pool/home/${var.hostname}"
    // Without 'volume' defined, Proxmox will try to create a volume with
    // the value of 'storage' + : + 'size' (without the trailing G) - e.g.
    // "/srv/host/bind-mount-point:256".
    // This behaviour looks to be caused by a bug in the provider.
    volume  = "/slow-pool/home/${var.hostname}"
    mp      = "/root"
    size    = "16G"
  }

  mountpoint {
    key     = "2"
    slot    = 2
    storage = "/mnt/env"
    // Without 'volume' defined, Proxmox will try to create a volume with
    // the value of 'storage' + : + 'size' (without the trailing G) - e.g.
    // "/srv/host/bind-mount-point:256".
    // This behaviour looks to be caused by a bug in the provider.
    volume  = "/mnt/env"
    mp      = "/mnt/env"
    size    = "1G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "${var.ipv4}/24"
    gw     = var.ipv4_gateway
  }

  network {
    name   = "eth1"
    bridge = "vmbr1"
    ip     = "${var.ipv4_data}/24"
  }
}