## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

provider "oci" {
  tenancy_ocid         = var.tenancy_ocid
  user_ocid            = var.user_ocid
  fingerprint          = var.fingerprint
  private_key_path     = var.private_key_path
  region               = var.region
}

provider "oci" {
  alias                = "region_lon"
  tenancy_ocid         = var.tenancy_ocid
  user_ocid            = var.user_ocid
  fingerprint          = var.fingerprint
  private_key_path     = var.private_key_path
  region               = var.region_a
}

provider "oci" {
  alias            = "region_fra"
  tenancy_ocid     = var.tenancy_ocid_b
  user_ocid        = var.user_ocid_b
  fingerprint      = var.fingerprint_b
  private_key_path = var.private_key_path_b
  region           = var.region_b
}

