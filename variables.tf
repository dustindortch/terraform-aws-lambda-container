variable "base_image" {
  description = "The base image to use for the container image."
  type = object({
    name     = string
    registry = optional(string, null)
    tag      = optional(string, null)
  })
}

variable "build_stage" {
  default     = null
  description = "The build stage to use for the container image."
  type = object({
    name     = optional(string, null)
    registry = optional(string, null)
    tag      = optional(string, null)
  })
}
variable "ecr_repository_name" {
  description = "The name of the ECR repository (container namespace and name) to publish container image."
  type        = string
}

variable "ecr_registry_id" {
  description = "The registry ID (AWS Account) of the ECR repository to publish container image."
  type        = string
}

variable "github_repository_contents" {
  description = "The GitHub repository release to use for the application code."
  type = object({
    name   = string
    branch = optional(string, null)
  })
}

variable "handler" {
  description = "The AWS Lambda handler to invoke within the container image."
  type        = string
}

variable "path" {
  description = "The path in the GitHub repository to the application code to copy."
  type        = string
}
