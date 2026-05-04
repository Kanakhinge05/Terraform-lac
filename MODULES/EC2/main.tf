resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
  #!/bin/bash
  yum update -y
  
  amazon-linux-extras enable nginx
  yum install -y nginx

  echo "<h1>Hallo from TERRAFORM-INFRA</h2>" > /usr/share/nginx/html/index.html
  systemctl enable nginx
  systemctl start nginx
  EOF

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
