## Copyright (c) 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl


# Groups created to manage HR Compartment

resource "oci_identity_group" "group1" {
  name           = "HR-Admins"
  description    = "group created for HR admins"
  compartment_id = var.tenancy_ocid
}

resource "oci_identity_group" "group2" {
  name           = "HR-Prod-Admins"
  description    = "group created for HR Prod admins"
  compartment_id = var.tenancy_ocid
}

resource "oci_identity_group" "group3" {
  name           = "HR-Staging-Admins"
  description    = "group created for HR Staging admins"
  compartment_id = var.tenancy_ocid
}

resource "oci_identity_group" "group4" {
  name           = "HR-Dev-Admins"
  description    = "group created for HR Dev admins"
  compartment_id = var.tenancy_ocid
}

resource "oci_identity_group" "group5" {
  name           = "HR-Test-Admins"
  description    = "group created for HR Test admins"
  compartment_id = var.tenancy_ocid
}


# Groups created to manage Sales Compartment

resource "oci_identity_group" "group11" {
  name           = "Sales-Admins"
  description    = "group created for Sales admins"
  compartment_id = var.tenancy_ocid
}

resource "oci_identity_group" "group21" {
  name           = "Sales-Prod-Admins"
  description    = "group created for HR Sales admins"
  compartment_id = var.tenancy_ocid
}

resource "oci_identity_group" "group31" {
  name           = "Sales-Staging-Admins"
  description    = "group created for Sales Staging admins"
  compartment_id = var.tenancy_ocid
}

resource "oci_identity_group" "group41" {
  name           = "Sales-Dev-Admins"
  description    = "group created for Sales Dev admins"
  compartment_id = var.tenancy_ocid
}

resource "oci_identity_group" "group51" {
  name           = "Sales-Test-Admins"
  description    = "group created for Sales Test admins"
  compartment_id = var.tenancy_ocid
}