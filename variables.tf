variable "resouce_group_name" {
  default="Serverlessq"
}

variable "location" {
  default = "West Europe"
}



variable "tag" {
  default = "Dev"
}


variable "failover_location" {
  default = "North Europe"
}


resource "random_integer" "ri" {
  min = 10000
  max = 99999
}


resource "random_string" "fqdn" {
    length  = 6
    special = false
    upper   = false
    number  = false
}


