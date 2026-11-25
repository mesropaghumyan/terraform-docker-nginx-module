resource "docker_image" "this" {
  name         = var.image_name
  keep_locally = false
}

resource "docker_container" "this" {
  count = var.container_count

  image      = docker_image.this.image_id
  name       = "nginx-instance-${count.index + 1}"
  memory     = var.container_memory
  privileged = var.privileged

  ports {
    internal = 80
    external = var.starting_port + count.index
  }

  upload {
    file       = "/docker-entrypoint.d/99-set-hostname.sh"
    executable = true
    content    = <<-EOF
      #!/bin/sh
      echo "<h1>Hostname du conteneur : $(hostname)</h1>" > /usr/share/nginx/html/index.html
    EOF
  }
}
