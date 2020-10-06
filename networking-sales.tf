## Copyright (c) 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Networking for Sales-Prod compartment

resource "oci_core_virtual_network" "prod_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  cidr_block     = "10.4.0.0/16"
  compartment_id =  oci_identity_compartment.level21.id
  display_name   = "Prod-Sales-Network"
  dns_label      = "prodsales"
}

resource "oci_core_internet_gateway" "internet_gateway_prod_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level21.id
  display_name   = "internet_gateway_prod_sales"
  vcn_id         = oci_core_virtual_network.prod_sales[0].id
}

resource "oci_core_route_table" "pubic_route_table_prod_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level21.id
  vcn_id         = oci_core_virtual_network.prod_sales[0].id
  display_name   = "RouteTableProdSales"
  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway_prod_sales[0].id
  }
}


resource "oci_core_nat_gateway" "nat_gateway_prod_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level21.id
  vcn_id         = oci_core_virtual_network.prod_sales[0].id
  display_name   = "nat_gateway_prod_sales"
}


resource "oci_core_route_table" "private_route_table_prod_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level21.id
  vcn_id         = oci_core_virtual_network.prod_sales[0].id
  display_name   = "private_route_table_prod_sales"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.nat_gateway_prod_sales[0].id
  }
}

resource "oci_core_security_list" "public_security_list_prod_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level21.id
  display_name   = "Public Security List Prod"
  vcn_id         = oci_core_virtual_network.prod_sales[0].id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    tcp_options {
      max = 22
      min = 22
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }
}


resource "oci_core_security_list" "private_security_list_prod_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level21.id
  display_name   = "Private Security List Prod Sales"
  vcn_id         = oci_core_virtual_network.prod_sales[0].id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules  {
    protocol = "all"
    source   = "10.0.0.0/24"
  }
}


# Regional subnet - public

resource "oci_core_subnet" "public_prod_sales" {
  count             = var.use_existing_vcn ? 0 : 1
  cidr_block        = "10.4.0.0/24"
  display_name      = "public-prod-sales"
  compartment_id    = oci_identity_compartment.level21.id
  vcn_id            = oci_core_virtual_network.prod_sales[0].id
  route_table_id    = oci_core_route_table.pubic_route_table_prod_sales[0].id
  security_list_ids = [oci_core_virtual_network.prod_sales[0].default_security_list_id, oci_core_security_list.public_security_list_prod_sales[0].id]
  dhcp_options_id   = oci_core_virtual_network.prod_sales[0].default_dhcp_options_id
}


# Regional subnet - private

resource "oci_core_subnet" "private_prod_sales" {
  count                      = var.use_existing_vcn ? 0 : 1
  cidr_block                 = "10.4.1.0/24"
  display_name               = "private-prod-sales"
  compartment_id             = oci_identity_compartment.level21.id
  vcn_id                     = oci_core_virtual_network.prod_sales[0].id
  route_table_id             = oci_core_route_table.private_route_table_prod_sales[0].id
  security_list_ids          = [oci_core_virtual_network.prod_sales[0].default_security_list_id, oci_core_security_list.private_security_list_prod_sales[0].id]
  dhcp_options_id            = oci_core_virtual_network.prod_sales[0].default_dhcp_options_id
  prohibit_public_ip_on_vnic = true
}


# Networking for Sales-Staging compartment

resource "oci_core_virtual_network" "staging_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  cidr_block     = "10.5.0.0/16"
  compartment_id =  oci_identity_compartment.level31.id
  display_name   = "Staging-Sales-Network"
  dns_label      = "stagingsales"
}

resource "oci_core_internet_gateway" "internet_gateway_staging_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level31.id
  display_name   = "internet_gateway_staging_sales"
  vcn_id         = oci_core_virtual_network.staging_sales[0].id
}

resource "oci_core_route_table" "pubic_route_table_staging_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level31.id
  vcn_id         = oci_core_virtual_network.staging_sales[0].id
  display_name   = "RouteTableStagingSales"
  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway_staging_sales[0].id
  }
}


resource "oci_core_nat_gateway" "nat_gateway_staging_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level31.id
  vcn_id         = oci_core_virtual_network.staging_sales[0].id
  display_name   = "nat_gateway_staging_sales"
}

resource "oci_core_route_table" "private_route_table_staging_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level31.id
  vcn_id         = oci_core_virtual_network.staging_sales[0].id
  display_name   = "private_route_table_staging_sales"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.nat_gateway_staging_sales[0].id
  }
}

resource "oci_core_security_list" "public_security_list_staging_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level31.id
  display_name   = "Public Security List Staging Sales"
  vcn_id         = oci_core_virtual_network.staging_sales[0].id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    tcp_options {
      max = 22
      min = 22
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }
}


resource "oci_core_security_list" "private_security_list_staging_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level31.id
  display_name   = "Private Security List Staging Sales"
  vcn_id         = oci_core_virtual_network.staging_sales[0].id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules  {
    protocol = "all"
    source   = "10.0.0.0/24"
  }
}


# Regional subnet - public

resource "oci_core_subnet" "public_staging_sales" {
  count             = var.use_existing_vcn ? 0 : 1
  cidr_block        = "10.5.0.0/24"
  display_name      = "public-staging-sales"
  compartment_id    = oci_identity_compartment.level31.id
  vcn_id            = oci_core_virtual_network.staging_sales[0].id
  route_table_id    = oci_core_route_table.pubic_route_table_staging_sales[0].id
  security_list_ids = [oci_core_virtual_network.staging_sales[0].default_security_list_id, oci_core_security_list.public_security_list_staging_sales[0].id]
  dhcp_options_id   = oci_core_virtual_network.staging_sales[0].default_dhcp_options_id
}


# Regional subnet - private

resource "oci_core_subnet" "private_staging_sales" {
  count                      = var.use_existing_vcn ? 0 : 1
  cidr_block                 = "10.5.1.0/24"
  display_name               = "private-staging-sales"
  compartment_id             = oci_identity_compartment.level31.id
  vcn_id                     = oci_core_virtual_network.staging_sales[0].id
  route_table_id             = oci_core_route_table.private_route_table_staging_sales[0].id
  security_list_ids          = [oci_core_virtual_network.staging_sales[0].default_security_list_id, oci_core_security_list.private_security_list_staging_sales[0].id]
  dhcp_options_id            = oci_core_virtual_network.staging_sales[0].default_dhcp_options_id
  prohibit_public_ip_on_vnic = true
}



# Networking for Sales-Dev compartment

resource "oci_core_virtual_network" "dev_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  cidr_block     = "10.6.0.0/16"
  compartment_id =  oci_identity_compartment.level41.id
  display_name   = "Dev-Sales-Network"
  dns_label      = "devsales"
}

resource "oci_core_internet_gateway" "internet_gateway_dev_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level41.id
  display_name   = "internet_gateway_dev_sales"
  vcn_id         = oci_core_virtual_network.dev_sales[0].id
}

resource "oci_core_route_table" "pubic_route_table_dev_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level41.id
  vcn_id         = oci_core_virtual_network.dev_sales[0].id
  display_name   = "RouteTableDevSales"
  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway_dev_sales[0].id
  }
}


resource "oci_core_nat_gateway" "nat_gateway_dev_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level41.id
  vcn_id         = oci_core_virtual_network.dev_sales[0].id
  display_name   = "nat_gateway_dev_sales"
}

resource "oci_core_route_table" "private_route_table_dev_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level41.id
  vcn_id         = oci_core_virtual_network.dev_sales[0].id
  display_name   = "private_route_table_dev_sales"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.nat_gateway_dev_sales[0].id
  }
}

resource "oci_core_security_list" "public_security_list_dev_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level41.id
  display_name   = "Public Security List Dev Sales"
  vcn_id         = oci_core_virtual_network.dev_sales[0].id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    tcp_options {
      max = 22
      min = 22
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }
}


resource "oci_core_security_list" "private_security_list_dev_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level41.id
  display_name   = "Private Security List Dev Sales"
  vcn_id         = oci_core_virtual_network.dev_sales[0].id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules  {
    protocol = "all"
    source   = "10.0.0.0/24"
  }
}


# Regional subnet - public

resource "oci_core_subnet" "public_dev_sales" {
  count             = var.use_existing_vcn ? 0 : 1
  cidr_block        = "10.6.0.0/24"
  display_name      = "public-dev-sales"
  compartment_id    = oci_identity_compartment.level41.id
  vcn_id            = oci_core_virtual_network.dev_sales[0].id
  route_table_id    = oci_core_route_table.pubic_route_table_dev_sales[0].id
  security_list_ids = [oci_core_virtual_network.dev_sales[0].default_security_list_id, oci_core_security_list.public_security_list_dev_sales[0].id]
  dhcp_options_id   = oci_core_virtual_network.dev_sales[0].default_dhcp_options_id
}


# Regional subnet - private

resource "oci_core_subnet" "private_dev_sales" {
  count                      = var.use_existing_vcn ? 0 : 1
  cidr_block                 = "10.6.1.0/24"
  display_name               = "private-dev-sales"
  compartment_id             = oci_identity_compartment.level41.id
  vcn_id                     = oci_core_virtual_network.dev_sales[0].id
  route_table_id             = oci_core_route_table.private_route_table_dev_sales[0].id
  security_list_ids          = [oci_core_virtual_network.dev_sales[0].default_security_list_id, oci_core_security_list.private_security_list_dev_sales[0].id]
  dhcp_options_id            = oci_core_virtual_network.dev_sales[0].default_dhcp_options_id
  prohibit_public_ip_on_vnic = true
}


# Networking for Sales-Test compartment

resource "oci_core_virtual_network" "test_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  cidr_block     = "10.7.0.0/16"
  compartment_id =  oci_identity_compartment.level51.id
  display_name   = "Test-Sales-Network"
  dns_label      = "testsales"
}

resource "oci_core_internet_gateway" "internet_gateway_test_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level51.id
  display_name   = "internet_gateway_test_sales"
  vcn_id         = oci_core_virtual_network.test_sales[0].id
}

resource "oci_core_route_table" "pubic_route_table_test_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level51.id
  vcn_id         = oci_core_virtual_network.test_sales[0].id
  display_name   = "RouteTableTestSales"
  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway_test_sales[0].id
  }
}


resource "oci_core_nat_gateway" "nat_gateway_test_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level51.id
  vcn_id         = oci_core_virtual_network.test_sales[0].id
  display_name   = "nat_gateway_test_sales"
}

resource "oci_core_route_table" "private_route_table_test_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level51.id
  vcn_id         = oci_core_virtual_network.test_sales[0].id
  display_name   = "private_route_table_test_sales"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.nat_gateway_test_sales[0].id
  }
}

resource "oci_core_security_list" "public_security_list_test_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level51.id
  display_name   = "Public Security List Test Sales"
  vcn_id         = oci_core_virtual_network.test_sales[0].id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    tcp_options {
      max = 22
      min = 22
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }
}


resource "oci_core_security_list" "private_security_list_test_sales" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level51.id
  display_name   = "Private Security List Test Sales"
  vcn_id         = oci_core_virtual_network.test_sales[0].id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules  {
    protocol = "all"
    source   = "10.0.0.0/24"
  }
}


# Regional subnet - public

resource "oci_core_subnet" "public_test_sales" {
  count             = var.use_existing_vcn ? 0 : 1
  cidr_block        = "10.7.0.0/24"
  display_name      = "public-test-sales"
  compartment_id    = oci_identity_compartment.level51.id
  vcn_id            = oci_core_virtual_network.test_sales[0].id
  route_table_id    = oci_core_route_table.pubic_route_table_test_sales[0].id
  security_list_ids = [oci_core_virtual_network.test_sales[0].default_security_list_id, oci_core_security_list.public_security_list_test_sales[0].id]
  dhcp_options_id   = oci_core_virtual_network.test_sales[0].default_dhcp_options_id
}


# Regional subnet - private

resource "oci_core_subnet" "private_test_sales" {
  count                      = var.use_existing_vcn ? 0 : 1
  cidr_block                 = "10.7.1.0/24"
  display_name               = "private-test-sales"
  compartment_id             = oci_identity_compartment.level51.id
  vcn_id                     = oci_core_virtual_network.test_sales[0].id
  route_table_id             = oci_core_route_table.private_route_table_test_sales[0].id
  security_list_ids          = [oci_core_virtual_network.test_sales[0].default_security_list_id, oci_core_security_list.private_security_list_test_sales[0].id]
  dhcp_options_id            = oci_core_virtual_network.test_sales[0].default_dhcp_options_id
  prohibit_public_ip_on_vnic = true
}