data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "cks-master" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"

  key_name = "cis-prep"
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.cks-prep-sg.id]
  associate_public_ip_address = true
  user_data                   = templatefile("./master.sh",{})

  tags = {
    Name = "cks-master"
  }
}

resource "aws_instance" "cks-worker" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  
  count = 2
  key_name = "cis-prep"
  subnet_id                   = module.vpc.public_subnets[count.index]
  vpc_security_group_ids      = [aws_security_group.cks-prep-sg.id]
  associate_public_ip_address = true
  user_data                   = templatefile("./worker.sh",{})
  tags = {
    Name = "cks-worker_${count.index}"
  }
}

