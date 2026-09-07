# Data Source — Dynamically fetch the latest Ubuntu 24.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's official AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# EC2 — Web Server (Public Subnet)
resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.web_sg_id]
  key_name                    = var.key_pair_name
  associate_public_ip_address = true

  # Install Nginx automatically on launch
  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install -y nginx
    echo "<h1>Provisioned by Terraform 🚀</h1><p>Web Server | ${var.project_name}</p>" \
      > /var/www/html/index.html
    systemctl start nginx
    systemctl enable nginx
  EOF

  tags = {
    Name        = "${var.project_name}-web-server"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# EC2 — App Server (Private Subnet)
resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.app_sg_id]
  key_name               = var.key_pair_name

  # Install Python automatically on launch
  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install -y python3 python3-pip
    echo "App server ready" > /home/ubuntu/status.txt
  EOF

  tags = {
    Name        = "${var.project_name}-app-server"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}