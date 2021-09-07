terraform {
  backend "remote" {
    organization = "TeraSky"

    workspaces {
      name = "cks-prep"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.38.0"
    }
  }

}
