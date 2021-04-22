terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.0.0"
    }
  }
}

provider "scaleway" {}

# bloc disque
resource "scaleway_instance_volume" "data" {
  count      = var.number_instance
  size_in_gb = var.disk_size
  type       = "b_ssd"
}

resource "scaleway_instance_ip" "public_ip" {
  count = var.number_instance
}

# bloc instance
resource "scaleway_instance_server" "Kube" {
  count                 = var.number_instance
  type                  = var.instance_type
  image                 = "ubuntu_focal"
  name                  = "--- [ Elephan - ${format("%02d", count.index + 1)} ] ---"
  additional_volume_ids = [scaleway_instance_volume.data[count.index].id]
  ip_id                 = scaleway_instance_ip.public_ip[count.index].id
  security_group_id     = scaleway_instance_security_group.sg.id
}

resource "scaleway_instance_security_group" "sg" {
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port   = "22"
  }
}
# output "ip_instance" {
#   value = scaleway_instance_ip.public_ip[*].address
# }

resource "scaleway_instance_server" "Fabrice-01" {
    count = 1
    type  = var.instance_typeXL
    image = "ubuntu_focal"
    name  = "Fabrice-01}"

    tags = ["Fabrice-01"]

    ip_id = scaleway_instance_ip.public_ip[count.index].id
  
    additional_volume_ids = [scaleway_instance_volume.data[count.index].id]

}

# module "application"{
#     source = "./modules/application"
# }

# module "elasticsearch"{
#     source = "./modules/elasticsearch"
# }
