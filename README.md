# terraform-gcp-vpc-module
Terraform Module to deploy a VPC into GCP


## Usage

```hcl
locals {
  network_prefixes = {
      kubernetes_pods          = "10.65.0.0/16"
      gcp_private_connect      = "10.64.128.0/19"
      kubernetes_services      = "10.64.224.0/20"
      private_primary          = "10.64.0.0/23"
      public_primary           = "10.64.64.0/23"
      serverless_vpc_connector = "10.64.96.0/28"
      kubernetes_master_nodes  = "10.64.96.16/28"
    }
}

module "vpc" {
  source = "git::https://github.com/GlueOps/terraform-gcp-vpc-module.git"

  workspace = var.workspace
  region    = "us-central1"

  network_prefixes = local.network_prefixes
}
```

## Inputs Required:

| Name             | Description                                                          | Required |
| ---------------- | -------------------------------------------------------------------- | -------- |
| workspace        | prefix of the TFC workspace name                                     | Yes      |
| region           | name of the gcp region                                               | Yes      |
| network_prefixes | prefixes to create. _refer to example above for ALL required ranges_ | Yes      |
