output "database_host" {
  description = "The hostname of the PostgreSQL database server"
  value       = "${helm_release.postgresql.id}-postgresql"
}

output "database_secret" {
  description = "The password of the PostgreSQL database server"
  value       = "${helm_release.postgresql.metadata}"
}

output "database_host_version" {
  value = helm_release.postgresql.version
}

output "database_host_status" {
  value = helm_release.postgresql.status
}