variable "image_name" {
  description = "Nom et tag de l'image Docker à utiliser"
  type        = string
  default     = "nginx:latest"
}

variable "container_memory" {
  description = "Limite de mémoire allouée au conteneur en Mo (ex: 512 pour 512 Mo)"
  type        = number
  default     = 512
}

variable "privileged" {
  description = "Exécuter le conteneur en mode privilégié ou non"
  type        = bool
  default     = false
}

variable "container_count" {
  description = "Nombre d'instances de conteneurs à déployer"
  type        = number
  default     = 1
}

variable "starting_port" {
  description = "Port hôte de départ (incrémenté de +1 pour chaque conteneur supplémentaire)"
  type        = number
  default     = 3000
}
