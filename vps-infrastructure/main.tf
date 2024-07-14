resource "null_resource" "app_server" {

  connection {
    type     = "ssh"
    user     = var.ssh_user
    password = var.ssh_password
    host     = var.ssh_host
    port     = var.ssh_port
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x install-docker.sh",
      "./install-docker.sh",
     ]
  }
}
