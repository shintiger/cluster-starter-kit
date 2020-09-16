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
    token   = string
    address = string
  })
}

variable "cluster" {
  type = object({
    instance_count = number
    tags           = list(string)
  })
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Create a web server
# Create a new Web Droplet in the sgp1 region
resource "digitalocean_droplet" "lolotiger" {
  count              = var.cluster.instance_count
  image              = "docker-20-04"
  name               = "lolotiger-terraform-${count.index}"
  region             = "sgp1"
  size               = "s-1vcpu-1gb"
  ssh_keys           = var.do_keys
  monitoring         = true
  private_networking = true
  resize_disk        = false
  tags               = var.cluster.tags
  user_data          = templatefile("./cloud-config.yml", { swarm_token = var.swarm.token, swarm_address = var.swarm.address, role = "frontend" })
}
