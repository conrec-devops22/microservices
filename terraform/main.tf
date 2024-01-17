
resource "kubernetes_namespace" "example" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "example" {
  metadata {
    name      = var.deploy_name
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
          image = "nginx:1.21.6"
          name  = "nginx-example"

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

resource "kubernetes_service" "example" {
  metadata {
    name = var.service_name
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "example-app"
    }

    port {
      protocol = "TCP"
      port     = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
}