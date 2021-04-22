terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.0.0"
    }
  }
}

resource "scaleway_instance_security_group" "scaleway" {
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  # SSH
  inbound_rule {
    action = "accept"
    port   = 22
  }

  # Grafana
  inbound_rule {
    action = "accept"
    port   = 3000
  }

  # Kibana
  inbound_rule {
    action = "accept"
    port   = 5601
  }

  # Prometheus
  inbound_rule {
    action = "accept"
    port   = 9090
  }
}
