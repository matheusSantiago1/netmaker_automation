resource "google_compute_network" "vpc_network" {
  name                    = "${var.project}-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "${var.project}-private-subnet"
  ip_cidr_range = "172.17.12.0/22"
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
}

resource "google_compute_firewall" "allow_ssh_from_iap" {
  name    = "${var.project}-firewall"
  network = google_compute_network.vpc_network.self_link
  source_ranges = [ "35.235.240.0/20" ]

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "443", "23"]
  }

  target_tags = [ "http-tag" ]
}

resource "google_compute_router" "router" {
  name    = "${var.project}-router"
  region  = var.region
  network = google_compute_network.vpc_network.id

}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.project}-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}