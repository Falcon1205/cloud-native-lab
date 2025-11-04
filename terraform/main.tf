# Sekcja providera
terraform {
    required_providers {
      proxmox = {
        source = "bpg/proxmox"
        version = "0.86.0"
      }
    }
    required_version = ">= 1.4.0"
}
# Sekcja konfiguracji połączenia
provider "proxmox" {
  endpoint  = var.proxmox_api_url
  insecure  = true
  api_token = "${var.proxmox_token_id}=${var.proxmox_token_secret}"
}

# Konfiguracja VM
locals {
    vm_config = {
        "k3s-master" = { vmid = 201, ip = "10.10.10.20", cores  = 2, memory = 4096, disk = 30 },
        "k3s-worker1" = { vmid = 202, ip = "10.10.10.21", cores  = 2, memory = 4096, disk = 30 },
        "k3s-worker2" = { vmid = 203, ip = "10.10.10.22", cores  = 2, memory = 4096, disk = 30 }
    }
}

# Tworzenie  zasobów
resource "proxmox_virtual_environment_vm" "k3s_nodes" {
  for_each = local.vm_config

  name        = each.key
  node_name   = "asgard"
  vm_id       = each.value.vmid

  clone {
    node_name = "asgard"
    vm_id     = 900  # ID Twojego szablonu VM (np. template)
  }

  cpu {
    cores   = each.value.cores
    sockets = 1
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = each.value.disk
  }

  network_device {
    model      = "virtio"
    bridge     = var.bridge
  }

  initialization {
    datastore_id = "local-lvm"
    user_account {
      username = "ubuntu"
      keys     = [var.ssh_key]
    }
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = var.gateway
      }
    }
  }

  started = true
}

# --- LXC dla NFS ---
resource "proxmox_virtual_environment_container" "nfs_server" {
  node_name  = "asgard"
  vm_id      = 210

  operating_system {
    template_file_id = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  }

  initialization {
    hostname = "nfs-lxc"
    ip_config {
      ipv4 {
        address = "10.10.10.30/24"
        gateway = var.gateway
      }
    }
    user_account {
      keys = [var.ssh_key]
    }
  }

  memory {
    dedicated = 1024
  }

  cpu {
    cores = 1
  }

  disk {
    datastore_id = "local-lvm"
    size         = 20
  }

  network_interface {
    name   = "eth0"
    bridge = var.bridge
  }

  started = true
}