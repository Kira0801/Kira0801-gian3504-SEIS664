resource "google_compute_instance" "node-svc-01" {
  name         = "node-svc-01"
  machine_type = "f1-micro"
  zone         = "us-central1-c"

  # boot disk specifications
  boot_disk {
    initialize_params {
      image = "node-svc-base" // use image built with Packer
    }
  }

  # networks to attach to the VM
  network_interface {
    network = "default"
    access_config {} // use ephemeral public IP
  }
}

resource "google_compute_project_metadata" "node-svc-01" {
  metadata = {
    ssh-keys = "node-user:${file("~/.ssh/node-user.pub")}" // path to ssh key file
  }
}


resource "google_compute_instance" "node-svc-02" {
 name         = "node-svc-02"
 machine_type = "f1-micro"
 zone         = "us-central1-c"

#   # boot disk specifications
 boot_disk {
   initialize_params {
     image = "node-svc-base" // use image built with Packer
   }
 }

#   # networks to attach to the VM
 network_interface {
   network = "default"
   access_config {} // use ephemeral public IP
 }
}

resource "google_compute_project_metadata" "node-svc-02" {
 metadata = {
   ssh-keys = "node-user:${file("~/.ssh/node-user.pub")}" // path to ssh key file
 }
}

resource "google_compute_firewall" "node-svc" {
  name    = "allow-node-svc-tcp-3000"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }
  source_ranges = ["0.0.0.0/0"]
}
