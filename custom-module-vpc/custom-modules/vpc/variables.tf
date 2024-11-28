variable "vpc_config" {
  description = "To get the CIDR and NAME of vpc from user"
  type = object({
    cidr_block = string
    name = string
  })
  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid CIDR Format - ${var.vpc_config.cidr_block}"
  }
}

variable "subnet_config" {
  description = "Get the CIDR and AZ for subnets"
  type = map(object({
    cidr_block = string
    az         = string
    public = optional(bool, false)
  }))
  validation {
    condition = alltrue([for config in var.subnet_config: can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR Format"
  }
}