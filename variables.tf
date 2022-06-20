data "google_projects" "env_project" {
  filter = "lifecycleState:ACTIVE labels.environment=${var.workspace}"
}





