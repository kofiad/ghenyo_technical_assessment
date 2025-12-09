variable "db_username" {
  description = "username of the database user"
  type = string
  sensitive = false
}

variable "db_password" {
  description = "password of the database user"
  type = string
  sensitive = true
}

variable "db_instance_class" {
  description = "instance class of database"
  type = string
  default = "db.t2.micro"
}

variable "name" {
  description = "name of database"
  type = string
  default = ""
}

variable "db_engine" {
  description = "database engine"
  type = string
}

variable "db_name" {
  description = "name of the database"
  type = string
}

variable "allocated_storage" {
  description = "storage in GB of database"
  type = number
  default = 10
}

variable "vpc_id" {
  description = "ID of vpc"
  type = string
}

variable "database_port" {
  description = "port of database"
  type = number
}

variable "allowed_cidr_block" {
  description = "cidr block allowed to acess the database"
  type = list(string)
}

variable "engine_version" {
  description = "version of database engine"
  type = string
  default = ""
}

variable "max_allocated_storage" {
  description = "maximum storage of database for autoscaling"
  type = number
}

variable "kms_key_id" {
  description = "ID of the kms key for encryption"
  type = string
}

variable "private_subnet_ids" {
  description = "IDs of private subnets"
  type = list(string)
}