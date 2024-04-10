data "google_compute_image" "my_image" {
  family  = "debian-11"
  project = "debian-cloud"
}

resource "google_compute_instance" "netmaker" {
  name         = "${var.project}-compute"
  machine_type = "n2-standard-2"
  zone         = var.region

  tags = ["${var.project}-compute"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.my_image.self_link
      labels = {
        my_label = "${var.project}-disk"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.private_subnet.self_link
  }

  metadata = {
    ssh-keys = "user1:ssh-rsa mypublickey user1@host.com"
  }

  metadata_startup_script = "echo hi > /test.txt"

}
