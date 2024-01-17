variable "namespace" {
  type    = string
  default = "services"
}

variable "app_name" {
  type    = string
  default = "microservices"
}

variable "service1_deploy" {
  type    = string
  default = "service1-deploy-terraform"
}

variable "service2_deploy" {
  type    = string
  default = "service2-deploy-terraform"
}

variable "deploy_test_label" {
  type    = string
  default = "terraform-deploy-test-label"
}

variable "service1_image" {
  type    = string
  default = "change_me"
}

variable "service2_image" {
  type    = string
  default = "change_me"
}

variable "service1_name" {
  type    = string
  default = "service1-service"
}

variable "service2_name" {
  type    = string
  default = "service2-service"
}

variable "service_test_label" {
  type    = string
  default = "terraform-service-test-label"
}
