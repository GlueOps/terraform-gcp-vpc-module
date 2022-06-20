resource "google_compute_global_address" "gcp_managed_services" {
  name          = "${var.workspace}-gcp-services-network"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = split("/", var.network_prefixes["kubernetes_services"])[0]
  prefix_length = split("/", var.network_prefixes["kubernetes_services"])[1]
  network       = google_compute_network.vpc_network.id
}


resource "google_service_networking_connection" "foobar" {
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.gcp_managed_services.name]
}


