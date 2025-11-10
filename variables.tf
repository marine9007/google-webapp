variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "marine9007"
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a"
}

variable "machine_type" {
  description = "Machine type for the web server"
  type        = string
  default     = "e2-micro"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "basic-webapp"
}

