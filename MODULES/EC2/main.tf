resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name

  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = templatefile("${path.root}/user_data.sh", {
    html_content = file("${path.root}/index.html")
  })

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.instance_name}-sg"
  vpc_id = var.vpc_id
  description = "Security group for Terraform-infra EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
    description = "SSH access"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.http_cidr]
    description = "HTTP access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "infra-ec2-sg"
    ManagedBy = "Terraform"
  }
}
