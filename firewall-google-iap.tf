resource "google_compute_firewall" "google-iap" {
  project   = data.google_projects.env_project.projects[0].project_id
  name      = "allow-ingress-from-iap-${var.workspace}"
  network   = google_compute_network.vpc_network.name
  direction = "INGRESS"

  allow {
    protocol = "tcp"
  }

  source_ranges = ["35.235.240.0/20"] # https://cloud.google.com/iap/docs/using-tcp-forwarding
}

