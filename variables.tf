data "google_projects" "env_project" {
  filter = "lifecycleState:ACTIVE labels.environment=${var.workspace}"
}

variable "workspace" {}

variable "region" {
  type        = string
  default     = ""
  description = "The GCP region to deploy these networks into"
}


variable "network_prefixes" {
  type = map(string)

  default = {
    kubernetes_pods          = "10.0.0.0/16"
    gcp_private_connect      = "10.0.128.0/19"
    kubernetes_services      = "10.0.224.0/20"
    private_primary          = "10.0.0.0/23"
    public_primary           = "10.0.64.0/23"
    serverless_vpc_connector = "10.0.96.0/28"
    kubernetes_master_nodes  = "10.0.96.16/28"
  }

  description = "Mapping of network CIDRs to use for various GCP services"

}
