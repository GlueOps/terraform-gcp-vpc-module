resource "google_compute_network" "vpc_network" {
  project                         = data.google_projects.env_project.projects[0].project_id
  name                            = "${var.workspace}-vpc"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
  routing_mode                    = "REGIONAL"
}


resource "google_compute_route" "default" {
  name             = "internet-route"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.vpc_network.name
  priority         = 1000
  project          = data.google_projects.env_project.projects[0].project_id
  next_hop_gateway = "default-internet-gateway"
  description      = "Default route to the Internet."
}

