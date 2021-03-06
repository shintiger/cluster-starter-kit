# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {
  type = string
}

variable "do_keys" {
  type = list(number)
}

variable "swarm" {
  type = object({
    token        = string
    address      = string
    gelf_address = string
  })
}

variable "cluster" {
  type = object({
    project_name   = string
    start_index    = number
    instance_count = number
    tags           = list(string)
  })
}


terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
  required_version = ">= 0.13"
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# $5
# s-1vcpu-1gb

# $10
# s-1vcpu-2gb

# $15
# s-1vcpu-3gb - hidden
# s-2vcpu-2gb
# s-3vcpu-1gb - hidden

# $20
# s-2vcpu-4gb

# $40
# s-4vcpu-8gb

# Create a new Web Droplet in the sgp1 region
resource "digitalocean_droplet" "cluster-frontend" {
  count              = var.cluster.instance_count
  image              = "docker-20-04"
  name               = "${var.cluster.project_name}-frontend-${(count.index + var.cluster.start_index) % 100}"
  region             = "sgp1"
  size               = "s-1vcpu-2gb"
  ssh_keys           = var.do_keys
  monitoring         = true
  private_networking = true
  resize_disk        = false
  tags               = var.cluster.tags
  user_data          = templatefile("./cloud-config-gelf.yml", { swarm_token = var.swarm.token, swarm_address = var.swarm.address, role = "frontend", gelf_address = var.swarm.gelf_address })
}

resource "digitalocean_droplet" "cluster-logging" {
  lifecycle {
    ignore_changes = [
      tags,
      ssh_keys,
      user_data
    ]
  }
  count              = 1
  image              = "docker-20-04"
  name               = "${var.cluster.project_name}-logging-${(count.index) % 100}"
  region             = "sgp1"
  size               = "s-1vcpu-3gb"
  ssh_keys           = var.do_keys
  monitoring         = true
  private_networking = true
  resize_disk        = false
  tags               = ["logging"]
  user_data          = templatefile("./cloud-config.yml", { swarm_token = var.swarm.token, swarm_address = var.swarm.address, role = "logging" })
}

resource "digitalocean_droplet" "cluster-controller" {
  lifecycle {
    ignore_changes = [
      tags,
      user_data
    ]
  }
  count              = 1
  image              = "docker-20-04"
  name               = "${var.cluster.project_name}-controller-${(count.index) % 100}"
  region             = "sgp1"
  size               = "s-1vcpu-1gb"
  ssh_keys           = var.do_keys
  monitoring         = true
  private_networking = true
  resize_disk        = false
  tags               = ["controller"]
  user_data          = templatefile("./cloud-config-gelf.yml", { swarm_token = var.swarm.token, swarm_address = var.swarm.address, role = "controller", gelf_address = var.swarm.gelf_address })
}
