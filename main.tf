# VPC Network
resource "google_compute_network" "webapp_network" {
  name                    = "${var.app_name}-network"
  auto_create_subnetworks = true
}

# Firewall rule to allow HTTP/HTTPS traffic
resource "google_compute_firewall" "webapp_firewall" {
  name    = "${var.app_name}-allow-http"
  network = google_compute_network.webapp_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}

# Firewall rule to allow SSH
resource "google_compute_firewall" "ssh_firewall" {
  name    = "${var.app_name}-allow-ssh"
  network = google_compute_network.webapp_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}

# Compute Engine instance with nginx
resource "google_compute_instance" "webapp_instance" {
  name         = "${var.app_name}-instance"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["web-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
    }
  }

  network_interface {
    network = google_compute_network.webapp_network.name

    access_config {
      # Ephemeral public IP (free, changes if instance restarts)
    }
  }

  metadata_startup_script = file("${path.module}/startup-script.sh")

  service_account {
    scopes = ["cloud-platform"]
  }

  allow_stopping_for_update = true
}

