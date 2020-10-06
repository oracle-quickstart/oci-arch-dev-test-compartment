## Copyright (c) 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Networking for HR-Prod compartment

resource "oci_core_virtual_network" "prod" {
  count          = var.use_existing_vcn ? 0 : 1
  cidr_block     = "10.0.0.0/16"
  compartment_id =  oci_identity_compartment.level2.id
  display_name   = "Prod-Network"
  dns_label      = "prod"
}

resource "oci_core_internet_gateway" "internet_gateway_prod" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level2.id
  display_name   = "internet_gateway_prod"
  vcn_id         = oci_core_virtual_network.prod[0].id
}

resource "oci_core_route_table" "pubic_route_table_prod" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level2.id
  vcn_id         = oci_core_virtual_network.prod[0].id
  display_name   = "RouteTableProd"
  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway_prod[0].id
  }
}


resource "oci_core_nat_gateway" "nat_gateway_prod" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level2.id
  vcn_id         = oci_core_virtual_network.prod[0].id
  display_name   = "nat_gateway_prod"
}


resource "oci_core_route_table" "private_route_table_prod" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level2.id
  vcn_id         = oci_core_virtual_network.prod[0].id
  display_name   = "private_route_table_prod"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.nat_gateway_prod[0].id
  }
}

resource "oci_core_security_list" "public_security_list_prod" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level2.id
  display_name   = "Public Security List Prod"
  vcn_id         = oci_core_virtual_network.prod[0].id

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


resource "oci_core_security_list" "private_security_list_prod" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level2.id
  display_name   = "Private Security List Prod"
  vcn_id         = oci_core_virtual_network.prod[0].id

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

resource "oci_core_subnet" "public_prod" {
  count             = var.use_existing_vcn ? 0 : 1
  cidr_block        = "10.0.0.0/24"
  display_name      = "public-prod"
  compartment_id    = oci_identity_compartment.level2.id
  vcn_id            = oci_core_virtual_network.prod[0].id
  route_table_id    = oci_core_route_table.pubic_route_table_prod[0].id
  security_list_ids = [oci_core_virtual_network.prod[0].default_security_list_id, oci_core_security_list.public_security_list_prod[0].id]
  dhcp_options_id   = oci_core_virtual_network.prod[0].default_dhcp_options_id
}


# Regional subnet - private

resource "oci_core_subnet" "private_prod" {
  count                      = var.use_existing_vcn ? 0 : 1
  cidr_block                 = "10.0.1.0/24"
  display_name               = "private-prod"
  compartment_id             = oci_identity_compartment.level2.id
  vcn_id                     = oci_core_virtual_network.prod[0].id
  route_table_id             = oci_core_route_table.private_route_table_prod[0].id
  security_list_ids          = [oci_core_virtual_network.prod[0].default_security_list_id, oci_core_security_list.private_security_list_prod[0].id]
  dhcp_options_id            = oci_core_virtual_network.prod[0].default_dhcp_options_id
  prohibit_public_ip_on_vnic = true
}


# Networking for HR-Staging compartment

resource "oci_core_virtual_network" "staging" {
  count          = var.use_existing_vcn ? 0 : 1
  cidr_block     = "10.1.0.0/16"
  compartment_id =  oci_identity_compartment.level3.id
  display_name   = "Staging-Network"
  dns_label      = "Staging"
}

resource "oci_core_internet_gateway" "internet_gateway_staging" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level3.id
  display_name   = "internet_gateway_staging"
  vcn_id         = oci_core_virtual_network.staging[0].id
}

resource "oci_core_route_table" "pubic_route_table_staging" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level3.id
  vcn_id         = oci_core_virtual_network.staging[0].id
  display_name   = "RouteTableStaging"
  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway_staging[0].id
  }
}


resource "oci_core_nat_gateway" "nat_gateway_staging" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level3.id
  vcn_id         = oci_core_virtual_network.staging[0].id
  display_name   = "nat_gateway_staging"
}

resource "oci_core_route_table" "private_route_table_staging" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level3.id
  vcn_id         = oci_core_virtual_network.staging[0].id
  display_name   = "private_route_table_staging"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.nat_gateway_staging[0].id
  }
}

resource "oci_core_security_list" "public_security_list_staging" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level3.id
  display_name   = "Public Security List Staging"
  vcn_id         = oci_core_virtual_network.staging[0].id

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


resource "oci_core_security_list" "private_security_list_staging" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level3.id
  display_name   = "Private Security List Staging"
  vcn_id         = oci_core_virtual_network.staging[0].id

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

resource "oci_core_subnet" "public_staging" {
  count             = var.use_existing_vcn ? 0 : 1
  cidr_block        = "10.1.0.0/24"
  display_name      = "public-staging"
  compartment_id    = oci_identity_compartment.level3.id
  vcn_id            = oci_core_virtual_network.staging[0].id
  route_table_id    = oci_core_route_table.pubic_route_table_staging[0].id
  security_list_ids = [oci_core_virtual_network.staging[0].default_security_list_id, oci_core_security_list.public_security_list_staging[0].id]
  dhcp_options_id   = oci_core_virtual_network.staging[0].default_dhcp_options_id
}


# Regional subnet - private

resource "oci_core_subnet" "private_staging" {
  count                      = var.use_existing_vcn ? 0 : 1
  cidr_block                 = "10.1.2.0/24"
  display_name               = "private-staging"
  compartment_id             = oci_identity_compartment.level3.id
  vcn_id                     = oci_core_virtual_network.staging[0].id
  route_table_id             = oci_core_route_table.private_route_table_staging[0].id
  security_list_ids          = [oci_core_virtual_network.staging[0].default_security_list_id, oci_core_security_list.private_security_list_staging[0].id]
  dhcp_options_id            = oci_core_virtual_network.staging[0].default_dhcp_options_id
  prohibit_public_ip_on_vnic = true
}



# Networking for HR-Dev compartment

resource "oci_core_virtual_network" "dev" {
  count          = var.use_existing_vcn ? 0 : 1
  cidr_block     = "10.2.0.0/16"
  compartment_id =  oci_identity_compartment.level4.id
  display_name   = "Dev-Network"
  dns_label      = "Dev"
}

resource "oci_core_internet_gateway" "internet_gateway_dev" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level4.id
  display_name   = "internet_gateway_dev"
  vcn_id         = oci_core_virtual_network.dev[0].id
}

resource "oci_core_route_table" "pubic_route_table_dev" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level4.id
  vcn_id         = oci_core_virtual_network.dev[0].id
  display_name   = "RouteTableDev"
  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway_dev[0].id
  }
}


resource "oci_core_nat_gateway" "nat_gateway_dev" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level4.id
  vcn_id         = oci_core_virtual_network.dev[0].id
  display_name   = "nat_gateway_dev"
}

resource "oci_core_route_table" "private_route_table_dev" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level4.id
  vcn_id         = oci_core_virtual_network.dev[0].id
  display_name   = "private_route_table_dev"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.nat_gateway_dev[0].id
  }
}

resource "oci_core_security_list" "public_security_list_dev" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level4.id
  display_name   = "Public Security List Dev"
  vcn_id         = oci_core_virtual_network.dev[0].id

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


resource "oci_core_security_list" "private_security_list_dev" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level4.id
  display_name   = "Private Security List Dev"
  vcn_id         = oci_core_virtual_network.dev[0].id

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

resource "oci_core_subnet" "public_dev" {
  count             = var.use_existing_vcn ? 0 : 1
  cidr_block        = "10.2.0.0/24"
  display_name      = "public-dev"
  compartment_id    = oci_identity_compartment.level4.id
  vcn_id            = oci_core_virtual_network.dev[0].id
  route_table_id    = oci_core_route_table.pubic_route_table_dev[0].id
  security_list_ids = [oci_core_virtual_network.dev[0].default_security_list_id, oci_core_security_list.public_security_list_dev[0].id]
  dhcp_options_id   = oci_core_virtual_network.dev[0].default_dhcp_options_id
}


# Regional subnet - private

resource "oci_core_subnet" "private_dev" {
  count                      = var.use_existing_vcn ? 0 : 1
  cidr_block                 = "10.2.1.0/24"
  display_name               = "private-dev"
  compartment_id             = oci_identity_compartment.level4.id
  vcn_id                     = oci_core_virtual_network.dev[0].id
  route_table_id             = oci_core_route_table.private_route_table_dev[0].id
  security_list_ids          = [oci_core_virtual_network.dev[0].default_security_list_id, oci_core_security_list.private_security_list_dev[0].id]
  dhcp_options_id            = oci_core_virtual_network.dev[0].default_dhcp_options_id
  prohibit_public_ip_on_vnic = true
}


# Networking for HR-Test compartment

resource "oci_core_virtual_network" "test" {
  count          = var.use_existing_vcn ? 0 : 1
  cidr_block     = "10.3.0.0/16"
  compartment_id =  oci_identity_compartment.level5.id
  display_name   = "Test-Network"
  dns_label      = "Test"
}

resource "oci_core_internet_gateway" "internet_gateway_test" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level5.id
  display_name   = "internet_gateway_test"
  vcn_id         = oci_core_virtual_network.test[0].id
}

resource "oci_core_route_table" "pubic_route_table_test" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level5.id
  vcn_id         = oci_core_virtual_network.test[0].id
  display_name   = "RouteTableTest"
  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway_test[0].id
  }
}


resource "oci_core_nat_gateway" "nat_gateway_test" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level5.id
  vcn_id         = oci_core_virtual_network.test[0].id
  display_name   = "nat_gateway_test"
}

resource "oci_core_route_table" "private_route_table_test" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level5.id
  vcn_id         = oci_core_virtual_network.test[0].id
  display_name   = "private_route_table_test"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.nat_gateway_test[0].id
  }
}

resource "oci_core_security_list" "public_security_list_test" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level5.id
  display_name   = "Public Security List Test"
  vcn_id         = oci_core_virtual_network.test[0].id

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


resource "oci_core_security_list" "private_security_list_test" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = oci_identity_compartment.level5.id
  display_name   = "Private Security List Test"
  vcn_id         = oci_core_virtual_network.test[0].id

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

resource "oci_core_subnet" "public_test" {
  count             = var.use_existing_vcn ? 0 : 1
  cidr_block        = "10.3.0.0/24"
  display_name      = "public-test"
  compartment_id    = oci_identity_compartment.level5.id
  vcn_id            = oci_core_virtual_network.test[0].id
  route_table_id    = oci_core_route_table.pubic_route_table_test[0].id
  security_list_ids = [oci_core_virtual_network.test[0].default_security_list_id, oci_core_security_list.public_security_list_test[0].id]
  dhcp_options_id   = oci_core_virtual_network.test[0].default_dhcp_options_id
}


# Regional subnet - private

resource "oci_core_subnet" "private_test" {
  count                      = var.use_existing_vcn ? 0 : 1
  cidr_block                 = "10.3.1.0/24"
  display_name               = "private-test"
  compartment_id             = oci_identity_compartment.level5.id
  vcn_id                     = oci_core_virtual_network.test[0].id
  route_table_id             = oci_core_route_table.private_route_table_test[0].id
  security_list_ids          = [oci_core_virtual_network.test[0].default_security_list_id, oci_core_security_list.private_security_list_test[0].id]
  dhcp_options_id            = oci_core_virtual_network.test[0].default_dhcp_options_id
  prohibit_public_ip_on_vnic = true
}