# Deploy two lambda for testing with awspec

module "aws-stop-friday" {
  source                         = "../.."
  name                           = "stop-aws"
  cloudwatch_schedule_expression = "cron(0 23 ? * FRI *)"
  schedule_action                = "stop"
  autoscaling_schedule           = "true"
  spot_schedule                  = "terminate"
  ec2_schedule                   = "true"
  rds_schedule                   = "true"

  resources_tag = {
    key   = "tostop"
    value = "true"
  }
}

module "aws-start-monday" {
  source                         = "../.."
  name                           = "start-aws"
  cloudwatch_schedule_expression = "cron(0 07 ? * MON *)"
  schedule_action                = "start"
  autoscaling_schedule           = "true"
  spot_schedule                  = "false"
  ec2_schedule                   = "true"
  rds_schedule                   = "true"

  resources_tag = {
    key   = "tostop"
    value = "true"
  }
}
