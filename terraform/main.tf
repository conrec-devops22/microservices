resource "kubernetes_namespace" "example" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "deploy1" {
  metadata {
    name      = var.service1_deploy
    namespace = var.namespace
    labels    = {
      test = var.deploy_test_label
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        test = var.deploy_test_label
      }
    }

    template {
      metadata {
        labels = {
          test = var.deploy_test_label
        }
      }

      spec {
        container {
          image = var.service1_image
          name  = "service1-service"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "deploy2" {
  metadata {
    name      = var.service2_deploy
    namespace = var.namespace
    labels    = {
      test = var.deploy_test_label
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        test = var.deploy_test_label
      }
    }

    template {
      metadata {
        labels = {
          test = var.deploy_test_label
        }
      }

      spec {
        container {
          image = var.service2_image
          name  = "service2-service"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "service1" {
  metadata {
    name = var.service1_name
    namespace = var.namespace
  }

  spec {
    selector = {
      app = var.service1_deploy
    }

    port {
      port        = 5001
      target_port = 5001
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "service2" {
  metadata {
    name = var.service2_name
    namespace = var.namespace
  }

  spec {
    selector = {
      app = var.service2_deploy
    }

    port {
      port        = 5002
      target_port = 5002
    }

    type = "NodePort"
  }
}