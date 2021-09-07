module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.7.0"
  name = "lev-cks-prep"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Envoronment = "Test"
  }
}
