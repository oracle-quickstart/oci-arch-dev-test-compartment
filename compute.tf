## Copyright (c) 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Compute for HR-Prod 

resource "oci_core_instance" "hr_prod_instance" {
  count               = "2"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 2]["name"]
  compartment_id      = oci_identity_compartment.level2.id
  display_name        = "Instance-${count.index}"
  shape               = var.instance_shape
  subnet_id           = oci_core_subnet.private_prod[0].id

  source_details {
    source_type = "image"
    source_id = data.oci_core_images.InstanceImageOCID.images[0].id
  }

    metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
    }

  timeouts {
    create = "60m"
  }
}


# Compute for HR-Staging 

resource "oci_core_instance" "hr_staging_instance" {
  count               = "2"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 2]["name"]
  compartment_id      = oci_identity_compartment.level3.id
  display_name        = "Instance-${count.index}"
  shape               = var.instance_shape
  subnet_id           = oci_core_subnet.private_staging[0].id

  source_details {
    source_type = "image"
    source_id = data.oci_core_images.InstanceImageOCID.images[0].id
  }

    metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
    }

  timeouts {
    create = "60m"
  }
}

# Compute for HR-Dev

resource "oci_core_instance" "hr_dev_instance" {
  count               = "3"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 2]["name"]
  compartment_id      = oci_identity_compartment.level4.id
  display_name        = "Instance-${count.index}"
  shape               = var.instance_shape
  subnet_id           = oci_core_subnet.private_dev[0].id

  source_details {
    source_type = "image"
    source_id = data.oci_core_images.InstanceImageOCID.images[0].id
  }

    metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
    }

  timeouts {
    create = "60m"
  }
}

# Compute for HR-Test

resource "oci_core_instance" "hr_test_instance" {
  count               = "2"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 2]["name"]
  compartment_id      = oci_identity_compartment.level5.id
  display_name        = "Instance-${count.index}"
  shape               = var.instance_shape
  subnet_id           = oci_core_subnet.private_test[0].id

  source_details {
    source_type = "image"
    source_id = data.oci_core_images.InstanceImageOCID.images[0].id
  }

    metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
    }

  timeouts {
    create = "60m"
  }
}


# Compute for Sales-Prod 

resource "oci_core_instance" "sales_prod_instance" {
  count               = "2"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 2]["name"]
  compartment_id      = oci_identity_compartment.level21.id
  display_name        = "Instance-${count.index}"
  shape               = var.instance_shape
  subnet_id           = oci_core_subnet.private_prod_sales[0].id

  source_details {
    source_type = "image"
    source_id = data.oci_core_images.InstanceImageOCID.images[0].id
  }

    metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
    }

  timeouts {
    create = "60m"
  }
}


# Compute for Sales-Staging 

resource "oci_core_instance" "sales_staging_instance" {
  count               = "2"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 2]["name"]
  compartment_id      = oci_identity_compartment.level31.id
  display_name        = "Instance-${count.index}"
  shape               = var.instance_shape
  subnet_id           = oci_core_subnet.private_staging_sales[0].id

  source_details {
    source_type = "image"
    source_id = data.oci_core_images.InstanceImageOCID.images[0].id
  }

    metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
    }

  timeouts {
    create = "60m"
  }
}

# Compute for Sales-Dev

resource "oci_core_instance" "sales_dev_instance" {
  count               = "3"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 2]["name"]
  compartment_id      = oci_identity_compartment.level41.id
  display_name        = "Instance-${count.index}"
  shape               = var.instance_shape
  subnet_id           = oci_core_subnet.private_dev_sales[0].id

  source_details {
    source_type = "image"
    source_id = data.oci_core_images.InstanceImageOCID.images[0].id
  }

    metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
    }

  timeouts {
    create = "60m"
  }
}

# Compute for Sales-Test

resource "oci_core_instance" "sales_test_instance" {
  count               = "2"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 2]["name"]
  compartment_id      = oci_identity_compartment.level51.id
  display_name        = "Instance-${count.index}"
  shape               = var.instance_shape
  subnet_id           = oci_core_subnet.private_test_sales[0].id

  source_details {
    source_type = "image"
    source_id = data.oci_core_images.InstanceImageOCID.images[0].id
  }

    metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
    }

  timeouts {
    create = "60m"
  }
}