resource "google_vpc_access_connector" "connector" {
  project       = data.google_projects.env_project.projects[0].project_id
  name          = "vpc-access-connector"
  ip_cidr_range = var.network_prefixes["serverless_vpc_connector"]
  network       = google_compute_network.vpc_network.name
  region        = var.region
  count         = var.enable_google_vpc_access_connector ? 1 : 0
}

moved {
  from = module.vpc.google_vpc_access_connector.connector
  to   = module.vpc.google_vpc_access_connector.connector[0]
}