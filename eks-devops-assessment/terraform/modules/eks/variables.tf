variable "cluster_name" {}
variable "cluster_version" {}
variable "vpc_id" {}
variable "subnet_ids" {}
variable "instance_types" {}
variable "min_size" {}
variable "max_size" {}
variable "desired_size" {}
variable "tags" {
  type = map(string)
}
