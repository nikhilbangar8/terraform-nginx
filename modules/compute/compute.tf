data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0*"]
    # values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Canonical
}

resource "aws_lb" "nginx-load-balancer" {
  name               = "nginx-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nginx-alb-sg.id]
  subnets            = [ var.primary_subnet_id, var.secondary_subnet_id ]

  tags = {
    Name = "nginx-load-balancer"
  }
}

resource "aws_lb_listener" "nginx-http-listner" {
  load_balancer_arn = aws_lb.nginx-load-balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-tg.arn
  }
}

resource "aws_lb_target_group" "nginx-tg" {
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "nginx-ec2-tg-attachment" {
  target_group_arn = aws_lb_target_group.nginx-tg.arn
  target_id        = aws_instance.nginx-server.id
  port             = 80
}

resource "aws_instance" "nginx-server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.primary_subnet_id
  user_data                   = file("modules/compute/userdata.sh")
  vpc_security_group_ids      = [aws_security_group.nginx-server-sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "Nginx-Server"
  }
}
resource "aws_security_group" "nginx-server-sg" {
  name        = "nginx-server-sg"
  description = "Security Froup attached to the Nginx-Server"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.nginx-alb-sg.id]
  }

  ingress {
    description = "ssh Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_access_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "nginx-server-sg"
  }
}

resource "aws_security_group" "nginx-alb-sg" {
  name        = "nginx-alb-sg"
  description = "Security Froup attached to the Nginx-Server"
  vpc_id      = var.vpc_id

  ingress {
    description = "open to internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "nginx-alb-sg"
  }
}
