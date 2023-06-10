module "lxc-module" {
  source       = "prashantsolanki3/lxc-module/proxmox"
  version      = "0.0.3"
  target_node  = var.target_node
  # General Config
  unprivileged = var.unprivileged
  hostname = var.hostname
  description  = var.description
  template     = var.template
  ostype       = var.ostype
  cpu_count    = var.cpu_count
  memory        = var.memory
  disk_size = var.disk_size
  disk_storage = var.disk_storage
  public_key_file = var.public_key_file

  # Network Config
  ipv4_gateway = var.ipv4_gateway
  ipv4         = var.ipv4
  ipv4_data    = var.ipv4_data

}
