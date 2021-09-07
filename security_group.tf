resource "aws_security_group" "cks-prep-sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress = [
    {
      description      = "all from my IP and same sg"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["84.229.119.73/32"]
      self = true
      ipv6_cidr_blocks = []
      security_groups = []
      prefix_list_ids = []
    }
  ]

  egress = [
    {
      description      = "all outgoing traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      self = true
      security_groups = []
      prefix_list_ids = []
    }
  ]

  tags = {
    Name = "cks-prep-sg"
  }
}

