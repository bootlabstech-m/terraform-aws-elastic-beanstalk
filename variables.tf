variable "region" {
  description = "Region of the resource to be created."
  type        = string
  default     = "ap-south-1"
}
variable "bucket" {
  description = "Bucket for the code base of the application"
  type        = string
}
variable "env_name" {
  description = "Environment for the beanstalk"
  type        = string
}
variable "solution_stack_name" {
  description = "Runtime solution stack name as per Beanstalk documentation"
  type        = string
}
variable "application_name" {
  description = "Application name"
  type        = string
}
variable "beanstalkservicerole_name" {
  description = "Role name for beanstalk service"
  type        = string
  default     = "beanstalkservice_role"
}
variable "beanstalkrole_name" {
  description = "Role name for beanstalk"
  type        = string
  default     = "beanstalk_role"
}
variable "beanstalk_instance_profile" {
  description = "Instance profile for beanstalk"
  type        = string
  default     = "instance_profile"
}
variable "app_version_name" {
  description = "Name for the app version"
  type        = string
  default     = "v1"
}

