resource "google_compute_router" "router" {
  project = data.google_projects.env_project.projects[0].project_id
  name    = "${var.workspace}-router-${local.region}"
  region  = local.region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  project                            = data.google_projects.env_project.projects[0].project_id
  name                               = "${var.workspace}-nat-${local.region}"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.private-network.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ip_allocate_option = "AUTO_ONLY"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
