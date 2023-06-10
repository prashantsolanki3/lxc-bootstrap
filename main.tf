module "lxc-module" {
  source       = "prashantsolanki3/lxc-module/proxmox"
  version      = "0.0.3"
  target_node  = var.target_node
  ipv4_gateway = var.ipv4_gateway
  ipv4         = var.ipv4
  ipv4_data    = var.ipv4_data
}
