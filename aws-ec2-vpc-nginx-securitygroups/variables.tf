# Define a variable and we can use at other places and use it as var.region
variable "region" {
  description = "Value of region"
  type = string
  default = "us-east-1"
}