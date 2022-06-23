resource "google_compute_router" "router" {
  project = data.google_projects.env_project.projects[0].project_id
  name    = "${var.workspace}-${var.region}-router"
  region  = var.region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  project                            = data.google_projects.env_project.projects[0].project_id
  name                               = "${var.workspace}-${var.region}-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  nat_ip_allocate_option = "AUTO_ONLY"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

