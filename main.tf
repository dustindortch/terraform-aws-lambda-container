terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    # github = {
    #   source  = "integrations/github"
    #   version = "~> 6.0"
    # }
  }
}

provider "aws" {}

# provider "github" {}

# data "github_repository" "repo" {
#   name = var.github_repository_contents.name
# }

# data "github_branch" "branch" {
#   repository = data.github_repository.repo.name
#   branch     = var.github_repository_contents.branch == null ? data.github_repository.repo.default_branch : var.github_repository_contents.branch
# }

# data "github_tree" "tree" {
#   recursive  = true
#   repository = data.github_repository.repo.name
#   tree_sha   = data.github_branch.branch.sha
# }

# locals {
#   tree_files = { for i in data.github_tree.tree.entries : i.sha => i }
# }

# data "github_repository_file" "file" {
#   for_each = local.tree_files

#   repository = data.github_repository.repo.name
#   branch     = data.github_branch.branch.ref
#   file       = each.value.path
# }

# locals {
#   file_contents = {
#     for k, v in data.github_repository_file.file : k => {
#       content = v.content
#       path    = local.tree_files[k].path
#     } if local.tree_files[k].type == "blob" && !startswith(local.tree_files[k].path, ".")
#   }
# }

# resource "local_file" "files" {
#   for_each = local.file_contents

#   filename = "${path.cwd}/${each.value.path}"
#   content  = each.value.content
# }

resource "aws_ecr_repository" "lambda" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_ecr_authorization_token" "lambda" {}

provider "docker" {
  host = "unix:///var/run/docker.sock"

  registry_auth {
    address  = data.aws_ecr_authorization_token.lambda.proxy_endpoint
    username = data.aws_ecr_authorization_token.lambda.user_name
    password = data.aws_ecr_authorization_token.lambda.password
  }
}

locals {
  build_stage = merge(
    var.build_stage,
    {
      path = var.path
    }
  )
}

module "docker" {
  depends_on = [local_file.files]
  source     = "app.terraform.io/DustinDortch/aws-lambda/docker"
  version    = "~> 1.0"

  name    = aws_ecr_repository.lambda.repository_url
  handler = var.handler
  path    = var.path

  base_image = var.base_image

  build_stage = local.build_stage
}

output "registry_image_name" {
  value = module.docker.registry_image_name
}
