## Copyright (c) 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Policy created for HR Compartment

resource "oci_identity_policy" "policy1" {
  name           = "HR-and-Sales-Compartment-Policy"
  description    = "policy created for HR and Sales compartment"
  compartment_id =  var.compartment_ocid

  statements = [
    "Allow group ${oci_identity_group.group1.name} to manage all-resources in compartment ${oci_identity_compartment.level1.name}",
    "Allow group ${oci_identity_group.group11.name} to manage all-resources in compartment ${oci_identity_compartment.level11.name}",
  ]
}

resource "oci_identity_policy" "policy11" {
  name           = "HR-Policies"
  description    = "policy created for HR compartment"
  compartment_id = oci_identity_compartment.level1.id

  statements = [
    "Allow group ${oci_identity_group.group2.name} to manage all-resources in compartment ${oci_identity_compartment.level2.name}",
    "Allow group ${oci_identity_group.group3.name} to manage all-resources in compartment ${oci_identity_compartment.level3.name}",
    "Allow group ${oci_identity_group.group4.name} to manage all-resources in compartment ${oci_identity_compartment.level4.name}",
    "Allow group ${oci_identity_group.group5.name} to manage all-resources in compartment ${oci_identity_compartment.level5.name}",
  ]
}


resource "oci_identity_policy" "policy21" {
  name           = "Sales-Policies"
  description    = "policy created for Sales compartment"
  compartment_id = oci_identity_compartment.level11.id

  statements = [
    "Allow group ${oci_identity_group.group21.name} to manage all-resources in compartment ${oci_identity_compartment.level21.name}",
    "Allow group ${oci_identity_group.group31.name} to manage all-resources in compartment ${oci_identity_compartment.level31.name}",
    "Allow group ${oci_identity_group.group41.name} to manage all-resources in compartment ${oci_identity_compartment.level41.name}",
    "Allow group ${oci_identity_group.group51.name} to manage all-resources in compartment ${oci_identity_compartment.level51.name}",
  ]
}

