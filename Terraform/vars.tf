variable "AZURE_SUBSCRIPTION_ID" {}
variable "AZURE_TENANT_ID" {}
variable "AZURE_CLIENT_ID" {}
variable "AZURE_CLIENT_SECRET" {}
variable "AZURE_LOCATION" {}
variable "IMAGE_NAME" {}
variable "USERNAME" {}
variable "PASSWORD" {}
variable "VM_SIZE" {}
variable "HOSTNAME" {}
variable "NO_VMs" {
  description = "The no of VMs we want in our infra"
  default = "2"
}
