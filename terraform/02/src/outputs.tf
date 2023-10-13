output "platform" {
  value = {
    "${yandex_compute_instance.platform.name}" = yandex_compute_instance.platform.network_interface.0.nat_ip_address
  }
}
output "platform-db" {
  value = {
    "${yandex_compute_instance.platform-db.name}" = yandex_compute_instance.platform-db.network_interface.0.nat_ip_address
  }
}
