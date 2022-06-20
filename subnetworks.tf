resource "google_compute_subnetwork" "public-network" {
  project                  = data.google_projects.env_project.projects[0].project_id
  name                     = "public-subnetwork"
  description              = "Public Subnetwork"
  ip_cidr_range            = var.network_prefixes["public_primary"]
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 1
    metadata             = "INCLUDE_ALL_METADATA"
  }
}


resource "google_compute_subnetwork" "private-network" {
  project                  = data.google_projects.env_project.projects[0].project_id
  name                     = "private-subnetwork"
  description              = "Private Subnetwork"
  ip_cidr_range            = var.network_prefixes["private_primary"]
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "${var.workspace}-kubernetes-services"
    ip_cidr_range = var.network_prefixes["kubernetes_services"]
  }

  secondary_ip_range {
    range_name    = "${var.workspace}-kubernetes-pods"
    ip_cidr_range = var.network_prefixes["kubernetes_pods"]
  }

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 1
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

