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