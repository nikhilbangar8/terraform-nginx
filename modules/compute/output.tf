output "nginx-public-ip" {
  value = aws_instance.nginx-server.public_ip
}

output "nginx-loadbalancer-dns" {
  value = aws_lb.nginx-load-balancer.dns_name
}