provider "proxmox" {
  pm_api_url      = "https://${var.proxmox_ip}:8006/api2/json"
  pm_user         = var.proxmox_user
  pm_password     = var.proxmox_password
  pm_tls_insecure = true
  pm_debug        = true
}

provider "local" {

}

provider "null" {
  
}
