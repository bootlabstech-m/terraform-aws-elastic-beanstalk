resource "aws_iam_role" "beanstalk_service" {
name   = var.beanstalkservicerole_name
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "elasticbeanstalk.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
  lifecycle {
    ignore_changes = [tags]
  }
}
resource "aws_iam_instance_profile" "instance_profile" {
  name = var.beanstalk_instance_profile
  role = aws_iam_role.beanstalkrole.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "beanstalkrole" {
  name               = var.beanstalkrole_name
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
# S3 Bucket for Beanstalk Application Versions
resource "aws_s3_bucket" "beanstalk_bucket" {
  bucket = var.bucket
  acl    = "private"
  lifecycle {
    ignore_changes = [tags]
  }
}
# Upload Application Package to S3
resource "aws_s3_bucket_object" "app_package" {
  bucket = aws_s3_bucket.beanstalk_bucket.bucket
  key    = "sample-app.zip"
  source = "sample-app.zip" # Replace with the path to your app's zip file
}
resource "random_id" "bucket_id" {
  byte_length = 8
}

# # Elastic Beanstalk Environment
# resource "aws_elastic_beanstalk_environment" "tfenvtest" { 
#   depends_on            = [aws_iam_instance_profile.instance_profile]  
#   name                  = var.env_name
#   application           = aws_elastic_beanstalk_application.my_app.name
#   tier                  = "WebServer"
#   solution_stack_name   = var.solution_stack_name
# }

# Elastic Beanstalk Application
resource "aws_elastic_beanstalk_application" "my_app" {
  name        = var.application_name
  description = "Elastic Beanstalk Application for a sample web app"
    appversion_lifecycle {
    service_role          = aws_iam_role.beanstalk_service.arn
    max_count             = 128
    delete_source_from_s3 = false
  }
}

# Elastic Beanstalk Application Version
resource "aws_elastic_beanstalk_application_version" "my_app_version" {
  name        = var.app_version_name
  application = aws_elastic_beanstalk_application.my_app.name
  bucket      = aws_s3_bucket.beanstalk_bucket.bucket
  key         = "sample-app.zip"

  # Ensure the application package exists in the bucket
  depends_on = [aws_s3_bucket_object.app_package]
}




