## Copyright (c) 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Compartments for HR team

resource oci_identity_compartment "level1" {
  name = "HR-Compartment"
  description = "Compartment for HR team"
  compartment_id = var.compartment_ocid
  enable_delete  = true
}

resource oci_identity_compartment "level2" {
  name = "HR-Prod-Compartment"
  description = "Compartment for HR Prod team"
  compartment_id = oci_identity_compartment.level1.id
  enable_delete  = true
}

resource oci_identity_compartment "level3" {
  name = "HR-Staging-Compartment"
  description = "Compartment for HR Staging team"
  compartment_id = oci_identity_compartment.level1.id
  enable_delete  = true
}

resource oci_identity_compartment "level4" {
  name = "HR-Dev-Compartment"
  description = "Compartment for HR Dev team"
  compartment_id = oci_identity_compartment.level1.id
  enable_delete  = true
}

resource oci_identity_compartment "level5" {
  name = "HR-Test-Compartment"
  description = "Compartment for HR Test team"
  compartment_id = oci_identity_compartment.level1.id
}

# Compartments for Sales team

resource oci_identity_compartment "level11" {
  name = "Sales-Compartment"
  description = "Compartment for Sales team"
  compartment_id = var.compartment_ocid
  enable_delete  = true
}

resource oci_identity_compartment "level21" {
  name = "Sales-Prod-Compartment"
  description = "Compartment for Sales Prod team"
  compartment_id = oci_identity_compartment.level11.id
  enable_delete  = true
}

resource oci_identity_compartment "level31" {
  name = "Sales-Staging-Compartment"
  description = "Compartment for Sales Staging team"
  compartment_id = oci_identity_compartment.level11.id
  enable_delete  = true
}

resource oci_identity_compartment "level41" {
  name = "Sales-Dev-Compartment"
  description = "Compartment for Sales Dev team"
  compartment_id = oci_identity_compartment.level11.id
  enable_delete  = true
}

resource oci_identity_compartment "level51" {
  name = "Sales-Test-Compartment"
  description = "Compartment for Sales Test team"
  compartment_id = oci_identity_compartment.level11.id
  enable_delete  = true
}