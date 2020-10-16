#output "node_svc-01_public_ip" {
#  value = "${google_compute_instance.node-svc-01.network_interface.0.access_config.0.nat_ip}"
#}

#output "node_svc-02_public_ip" {
#  value = "${google_compute_instance.node-svc-02.network_interface.0.access_config.0.nat_ip}"
#}
