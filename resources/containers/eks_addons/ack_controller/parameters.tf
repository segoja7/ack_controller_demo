#eks_addons-parameters.tf
locals {
  env = {
    default = {
      create = false


      cluster_name      = var.cluster_name
      cluster_endpoint  = var.cluster_endpoint
      cluster_version   = var.cluster_platform_version
      oidc_provider_arn = var.oidc_provider_arn

      helm_releases = {
        ec2-controller = {
          name                = "ec2-controller"
          description         = "A Helm chart for ack ec2-controller"
          repository_username = data.aws_ecrpublic_authorization_token.token.user_name
          repository_password = data.aws_ecrpublic_authorization_token.token.password
          namespace           = "ack-system"
          chart_version       = "1.2.12"
          chart               = "ec2-chart"
          create_namespace    = true
          repository          = "oci://public.ecr.aws/aws-controllers-k8s"
          values = [templatefile("./helm-charts/ack_ec2_controller/values.yaml", {
            role-arn = var.role_arn_controller
            region   = "us-east-1"
          })]
        }
      }

    }
    "dev" = {
      create = true
    }
    "test" = {
      create = true
    }
  }
  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}
