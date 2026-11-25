output "container_names" {
  description = "Liste des noms des conteneurs créés"
  value       = docker_container.this[*].name
}

output "container_urls" {
  description = "Liste des URLs locales d'accès aux conteneurs"
  value       = [for i in range(var.container_count) : "http://localhost:${var.starting_port + i}"]
}
