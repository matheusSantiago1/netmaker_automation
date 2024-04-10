data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "allows" {
  name        = "${var.stage}-${var.project}-server-sg"
  description = "Allow TLS and SSH inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 51820
    to_port     = 51820
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 51821
    to_port     = 51821
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["187.37.86.15/32", "201.42.216.26/32"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"      = "${var.stage}-${var.project}-sg"
    "Project"   = var.project
    "Terraform" = "true"
  }
}


resource "aws_instance" "server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.small"
  key_name                    = "math-souza"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allows.id]

  provisioner "file" {
    source      = "${path.module}/ansible_files/nm-quick.sh"
    destination = "/home/ubuntu/nm-quick.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/aws/math-souza.pem")
      host        = aws_instance.server.public_dns
    }
  }

  provisioner "remote-exec" {
    inline = [
      "echo ----------------------",
      "echo Creating python folder for boto3",
      "echo ----------------------",
      "mkdir python",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/aws/math-souza.pem")
      host        = aws_instance.server.public_dns
    }
  }

  provisioner "file" {
    source      = "${path.module}/python/route53.py"
    destination = "/home/ubuntu/python/route53.py"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/aws/math-souza.pem")
      host        = aws_instance.server.public_dns
    }
  }
  
  provisioner "file" {
    source      = "${path.module}/python/create_secrets.py"
    destination = "/home/ubuntu/python/create_secrets.py"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/aws/math-souza.pem")
      host        = aws_instance.server.public_dns
    }
  }

  provisioner "file" {
    content = templatefile("${path.module}/ansible_files/netmaker_automation.yml",
      {
        access_key      = var.access_key
        secret_key      = var.secret_key
        hosted_zone_id  = var.hosted_zone_id
        netmaker_domain = var.netmaker_domain
        aws_region      = var.aws_region
        secret_name     = var.secret_name
    })
    destination = "/home/ubuntu/netmaker_automation.yml"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/aws/math-souza.pem")
      host        = aws_instance.server.public_dns
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 10",
      "sudo apt update",
      "sudo apt install software-properties-common -y",
      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y",
      "sudo ansible --version",
      "sleep 10",
      "sudo ansible-playbook -u root netmaker_automation.yml -vvv",

    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/aws/math-souza.pem")
      host        = aws_instance.server.public_dns
    }
  }

  tags = {
    "Name"      = "${var.stage}-${var.project}-ec2"
    "Project"   = var.project
    "Terraform" = "true"
  }
}
