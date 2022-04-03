# Creates 'environment' variable
variable "env" {
  type        = string
  default = "dev"
  description = "Specifices the infrastructure environment. (uat/sit/dev/prd)"
}

# Creates 'location' variable
variable "loc" {
    type = string
    default = "West Europe"
    description = "Specifices the location for the resource"  
}

# Creates 'resource group name' variable
variable "rg" {
    type = string
    description = "Specifices the resource group name to host the resource"
}