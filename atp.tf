## Copyright (c) 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_database_autonomous_database" "hr_prod_atp" {
  admin_password           = var.ATP_password
  compartment_id           = oci_identity_compartment.level2.id
  cpu_core_count           = var.ATP_database_cpu_core_count
  data_storage_size_in_tbs = var.ATP_database_data_storage_size_in_tbs
  db_name                  = "hrpa"
  db_version               = var.ATP_database_db_version
  display_name             = "hr-pr-atp"
  freeform_tags            = var.ATP_database_freeform_tags
  license_model            = var.ATP_database_license_model     
}

resource "oci_database_autonomous_database" "hr_staging_atp" {
  admin_password           = var.ATP_password
  compartment_id           = oci_identity_compartment.level3.id
  cpu_core_count           = var.ATP_database_cpu_core_count
  data_storage_size_in_tbs = var.ATP_database_data_storage_size_in_tbs
  db_name                  = "hrsa"
  db_version               = var.ATP_database_db_version
  display_name             = "hr-st-atp"
  freeform_tags            = var.ATP_database_freeform_tags
  license_model            = var.ATP_database_license_model     
}

resource "oci_database_autonomous_database" "hr_dev_atp" {
  admin_password           = var.ATP_password
  compartment_id           = oci_identity_compartment.level4.id
  cpu_core_count           = var.ATP_database_cpu_core_count
  data_storage_size_in_tbs = var.ATP_database_data_storage_size_in_tbs
  db_name                  = "hrda"
  db_version               = var.ATP_database_db_version
  display_name             = "hr-de-atp"
  freeform_tags            = var.ATP_database_freeform_tags
  license_model            = var.ATP_database_license_model     
}

resource "oci_database_autonomous_database" "hr_test_atp" {
  admin_password           = var.ATP_password
  compartment_id           = oci_identity_compartment.level5.id
  cpu_core_count           = var.ATP_database_cpu_core_count
  data_storage_size_in_tbs = var.ATP_database_data_storage_size_in_tbs
  db_name                  = "hrta"
  db_version               = var.ATP_database_db_version
  display_name             = "hr-te-atp"
  freeform_tags            = var.ATP_database_freeform_tags
  license_model            = var.ATP_database_license_model     
}



resource "oci_database_autonomous_database" "sales_prod_atp" {
  admin_password           = var.ATP_password
  compartment_id           = oci_identity_compartment.level21.id
  cpu_core_count           = var.ATP_database_cpu_core_count
  data_storage_size_in_tbs = var.ATP_database_data_storage_size_in_tbs
  db_name                  = "sapa"
  db_version               = var.ATP_database_db_version
  display_name             = "sa-pr-atp"
  freeform_tags            = var.ATP_database_freeform_tags
  license_model            = var.ATP_database_license_model     
}

resource "oci_database_autonomous_database" "sales_staging_atp" {
  admin_password           = var.ATP_password
  compartment_id           = oci_identity_compartment.level31.id
  cpu_core_count           = var.ATP_database_cpu_core_count
  data_storage_size_in_tbs = var.ATP_database_data_storage_size_in_tbs
  db_name                  = "sasa"
  db_version               = var.ATP_database_db_version
  display_name             = "sa-st-atp"
  freeform_tags            = var.ATP_database_freeform_tags
  license_model            = var.ATP_database_license_model     
}

resource "oci_database_autonomous_database" "sales_dev_atp" {
  admin_password           = var.ATP_password
  compartment_id           = oci_identity_compartment.level41.id
  cpu_core_count           = var.ATP_database_cpu_core_count
  data_storage_size_in_tbs = var.ATP_database_data_storage_size_in_tbs
  db_name                  = "sada"
  db_version               = var.ATP_database_db_version
  display_name             = "sa-de-atp"
  freeform_tags            = var.ATP_database_freeform_tags
  license_model            = var.ATP_database_license_model     
}

resource "oci_database_autonomous_database" "sales_test_atp" {
  admin_password           = var.ATP_password
  compartment_id           = oci_identity_compartment.level51.id
  cpu_core_count           = var.ATP_database_cpu_core_count
  data_storage_size_in_tbs = var.ATP_database_data_storage_size_in_tbs
  db_name                  = "sata"
  db_version               = var.ATP_database_db_version
  display_name             = "sa-te-atp"
  freeform_tags            = var.ATP_database_freeform_tags
  license_model            = var.ATP_database_license_model     
}