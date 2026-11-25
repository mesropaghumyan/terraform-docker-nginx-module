variable "image_name" {
  description = "Nom et tag de l'image Docker à utiliser"
  type        = string
  default     = "nginx:latest"

  validation {
    condition     = length(trimspace(var.image_name)) > 0 && can(regex("^nginx(:[a-zA-Z0-9._-]+)?$", var.image_name))
    error_message = "L'image doit être une image officielle Nginx valide (ex: 'nginx:latest' ou 'nginx:alpine')."
  }
}

variable "container_memory" {
  description = "Limite de mémoire allouée au conteneur en Mo (minimum 6 Mo requis par Docker)"
  type        = number
  default     = 512

  validation {
    condition     = var.container_memory >= 64 && var.container_memory <= 8192
    error_message = "La mémoire allouée au conteneur doit être comprise entre 64 Mo et 8192 Mo (8 Go)."
  }
}

variable "privileged" {
  description = "Exécuter le conteneur en mode privilégié ou non"
  type        = bool
  default     = false

  validation {
    condition     = var.privileged == false
    error_message = "Par mesure de sécurité, l'exécution de conteneurs Nginx en mode privilégié (privileged = true) est interdite."
  }
}

variable "container_count" {
  description = "Nombre d'instances de conteneurs à déployer"
  type        = number
  default     = 1

  validation {
    condition     = var.container_count >= 1 && var.container_count <= 20 && floor(var.container_count) == var.container_count
    error_message = "Le nombre de conteneurs doit être un entier compris entre 1 et 20."
  }
}

variable "starting_port" {
  description = "Port hôte de départ (incrémenté de +1 pour chaque conteneur supplémentaire)"
  type        = number
  default     = 3000

  validation {
    condition     = var.starting_port >= 1024 && (var.starting_port + var.container_count - 1) <= 65535
    error_message = "Le port de départ doit être supérieur ou égal à 1024 (ports non privilégiés) et la plage totale de ports ne doit pas dépasser 65535."
  }
}
