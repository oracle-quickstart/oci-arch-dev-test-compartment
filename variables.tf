## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Variables
variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "region_a" {}
variable "region_b" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}

variable "use_existing_vcn" {
  default = "false"
}

variable "instance_shape" {
  description = "Instance Shape"
  default     = "VM.Standard2.1"
}

# Specify any Default Value's here

variable "availability_domain" {
  default = "3"
}

# OS Images
variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "7.8"
}


variable "db_system_shape" {
  default = "VM.Standard2.1"
}

variable "db_edition" {
  default = "ENTERPRISE_EDITION"
}

variable "db_admin_password" {
  default = "BEstrO0ng_#12"
}

variable "db_name" {
  default = "aTFdb"
}

variable "db_version" {
  default = "12.1.0.2"
}

variable "hostname" {
  default = "myoracledb"
}

variable "data_storage_size_in_gb" {
  default = "256"
}

variable "node_count" {
  default = "1"
}

variable "ATP_database_cpu_core_count" {
  default = 1
}

variable "ATP_database_data_storage_size_in_tbs" {
  default = 1
}

variable "ATP_database_db_version" {
  default = "18c"
}

variable "ATP_database_defined_tags_value" {
  default = "value"
}

variable "ATP_database_freeform_tags" {
  default = {
    "Owner" = "ATP"
  }
}

variable "ATP_database_license_model" {
  default = "LICENSE_INCLUDED"
}

variable "ATP_tde_wallet_zip_file" {
  default = "tde_wallet_ATPdb1.zip"
}

variable "ATP_private_endpoint_label" {
  default = "ATPPrivateEndpoint"
}

variable "ATP_password" {
  default = "Bestrong12345"
}