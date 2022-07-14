output "nginx-public-ip" {
  value = module.compute.nginx-public-ip
}

output "nginx-loadbalancer-dns" {
  value = module.compute.nginx-loadbalancer-dns
}