resource "google_compute_router" "router" {
  project = data.google_projects.env_project.projects[0].project_id
  name    = "${var.workspace}-${var.region}-router"
  region  = var.region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_address" "address" {
  count  = var.number_of_ips_to_manually_allocate_to_cloud_nat
  name   = "${var.workspace}-${var.region}-nat-manual-ip-${count.index}"
  region = google_compute_router.router.region
}

resource "google_compute_router_nat" "nat" {
  project                            = data.google_projects.env_project.projects[0].project_id
  name                               = "${var.workspace}-${var.region}-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  nat_ip_allocate_option = var.number_of_ips_to_manually_allocate_to_cloud_nat > 0 ? "MANUAL_ONLY" : "AUTO_ONLY"
  nat_ips                = google_compute_address.address.*.self_link

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

