output "webapp_url" {
  description = "URL to access the web application"
  value       = "http://${google_compute_instance.webapp_instance.network_interface[0].access_config[0].nat_ip}"
}

output "public_ip" {
  description = "Ephemeral public IP address of the web server"
  value       = google_compute_instance.webapp_instance.network_interface[0].access_config[0].nat_ip
}

output "instance_name" {
  description = "Name of the compute instance"
  value       = google_compute_instance.webapp_instance.name
}

output "network_name" {
  description = "Name of the VPC network"
  value       = google_compute_network.webapp_network.name
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "gcloud compute ssh ${google_compute_instance.webapp_instance.name} --zone=${var.zone} --project=${var.project_id}"
}

