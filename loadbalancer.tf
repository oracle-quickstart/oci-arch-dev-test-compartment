## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# HR-LB-Production

resource "oci_load_balancer" "hr_lb_prod" {
  shape          = "100Mbps"
  compartment_id = oci_identity_compartment.level2.id

  subnet_ids = [
    oci_core_subnet.public_prod[0].id,
  ]

  display_name = "hr-prod-load-balancer"
}

resource "oci_load_balancer_backend_set" "hr_bs_prod" {
  name             = "hr-backend-prod"
  load_balancer_id = oci_load_balancer.hr_lb_prod.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "5000"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
    interval_ms         = "10000"
    return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_listener" "hr_ll_prod" {
  load_balancer_id         = oci_load_balancer.hr_lb_prod.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.hr_bs_prod.name
  port                     = 80
  protocol                 = "HTTP"
}

resource "oci_load_balancer_backend" "hr_bb_prod_1" {
  load_balancer_id = oci_load_balancer.hr_lb_prod.id
  backendset_name  = oci_load_balancer_backend_set.hr_bs_prod.name
  ip_address       = oci_core_instance.hr_prod_instance[0].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "hr_bb_prod_2" {
  load_balancer_id = oci_load_balancer.hr_lb_prod.id
  backendset_name  = oci_load_balancer_backend_set.hr_bs_prod.name
  ip_address       = oci_core_instance.hr_prod_instance[1].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}


# HR-LB-Staging

resource "oci_load_balancer" "hr_lb_staging" {
  shape          = "100Mbps"
  compartment_id = oci_identity_compartment.level3.id

  subnet_ids = [
    oci_core_subnet.public_staging[0].id,
  ]

  display_name = "hr-staging-load-balancer"
}

resource "oci_load_balancer_backend_set" "hr_bs_staging" {
  name             = "hr-backend-staging"
  load_balancer_id = oci_load_balancer.hr_lb_staging.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "5000"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
    interval_ms         = "10000"
    return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_listener" "hr_ll_staging" {
  load_balancer_id         = oci_load_balancer.hr_lb_staging.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.hr_bs_staging.name
  port                     = 80
  protocol                 = "HTTP"
}

resource "oci_load_balancer_backend" "hr_bb_staging_1" {
  load_balancer_id = oci_load_balancer.hr_lb_staging.id
  backendset_name  = oci_load_balancer_backend_set.hr_bs_staging.name
  ip_address       = oci_core_instance.hr_staging_instance[0].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "hr_bb_staging_2" {
  load_balancer_id = oci_load_balancer.hr_lb_staging.id
  backendset_name  = oci_load_balancer_backend_set.hr_bs_staging.name
  ip_address       = oci_core_instance.hr_staging_instance[1].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

# HR-LB-Dev

resource "oci_load_balancer" "hr_lb_dev" {
  shape          = "100Mbps"
  compartment_id = oci_identity_compartment.level4.id

  subnet_ids = [
    oci_core_subnet.public_dev[0].id,
  ]

  display_name = "hr-dev-load-balancer"
}

resource "oci_load_balancer_backend_set" "hr_bs_dev" {
  name             = "hr-backend-dev"
  load_balancer_id = oci_load_balancer.hr_lb_dev.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "5000"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
    interval_ms         = "10000"
    return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_listener" "hr_ll_dev" {
  load_balancer_id         = oci_load_balancer.hr_lb_dev.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.hr_bs_dev.name
  port                     = 80
  protocol                 = "HTTP"
}

resource "oci_load_balancer_backend" "hr_bb_dev_1" {
  load_balancer_id = oci_load_balancer.hr_lb_dev.id
  backendset_name  = oci_load_balancer_backend_set.hr_bs_dev.name
  ip_address       = oci_core_instance.hr_dev_instance[0].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "hr_bb_dev_2" {
  load_balancer_id = oci_load_balancer.hr_lb_dev.id
  backendset_name  = oci_load_balancer_backend_set.hr_bs_dev.name
  ip_address       = oci_core_instance.hr_dev_instance[1].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "hr_bb_dev_3" {
  load_balancer_id = oci_load_balancer.hr_lb_dev.id
  backendset_name  = oci_load_balancer_backend_set.hr_bs_dev.name
  ip_address       = oci_core_instance.hr_dev_instance[2].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}


# HR-LB-Test

resource "oci_load_balancer" "hr_lb_test" {
  shape          = "100Mbps"
  compartment_id = oci_identity_compartment.level5.id

  subnet_ids = [
    oci_core_subnet.public_test[0].id,
  ]

  display_name = "hr-test-load-balancer"
}

resource "oci_load_balancer_backend_set" "hr_bs_test" {
  name             = "hr-backend-test"
  load_balancer_id = oci_load_balancer.hr_lb_test.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "5000"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
    interval_ms         = "10000"
    return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_listener" "hr_ll_test" {
  load_balancer_id         = oci_load_balancer.hr_lb_test.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.hr_bs_test.name
  port                     = 80
  protocol                 = "HTTP"
}

resource "oci_load_balancer_backend" "hr_bb_test_1" {
  load_balancer_id = oci_load_balancer.hr_lb_test.id
  backendset_name  = oci_load_balancer_backend_set.hr_bs_test.name
  ip_address       = oci_core_instance.hr_test_instance[0].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "hr_bb_test_2" {
  load_balancer_id = oci_load_balancer.hr_lb_test.id
  backendset_name  = oci_load_balancer_backend_set.hr_bs_test.name
  ip_address       = oci_core_instance.hr_test_instance[1].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}


# Sales-LB-Production

resource "oci_load_balancer" "sales_lb_prod" {
  shape          = "100Mbps"
  compartment_id = oci_identity_compartment.level21.id

  subnet_ids = [
    oci_core_subnet.public_prod_sales[0].id,
  ]

  display_name = "sales-prod-load-balancer"
}

resource "oci_load_balancer_backend_set" "sales_bs_prod" {
  name             = "sales-backend-prod"
  load_balancer_id = oci_load_balancer.sales_lb_prod.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "5000"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
    interval_ms         = "10000"
    return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_listener" "sales_ll_prod" {
  load_balancer_id         = oci_load_balancer.sales_lb_prod.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.sales_bs_prod.name
  port                     = 80
  protocol                 = "HTTP"
}

resource "oci_load_balancer_backend" "sales_bb_prod_1" {
  load_balancer_id = oci_load_balancer.sales_lb_prod.id
  backendset_name  = oci_load_balancer_backend_set.sales_bs_prod.name
  ip_address       = oci_core_instance.sales_prod_instance[0].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "sales_bb_prod_2" {
  load_balancer_id = oci_load_balancer.sales_lb_prod.id
  backendset_name  = oci_load_balancer_backend_set.sales_bs_prod.name
  ip_address       = oci_core_instance.sales_prod_instance[1].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}


# Sales-LB-Staging

resource "oci_load_balancer" "sales_lb_staging" {
  shape          = "100Mbps"
  compartment_id = oci_identity_compartment.level31.id

  subnet_ids = [
    oci_core_subnet.public_staging_sales[0].id,
  ]

  display_name = "sales-staging-load-balancer"
}

resource "oci_load_balancer_backend_set" "sales_bs_staging" {
  name             = "sales-backend-staging"
  load_balancer_id = oci_load_balancer.sales_lb_staging.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "5000"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
    interval_ms         = "10000"
    return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_listener" "sales_ll_staging" {
  load_balancer_id         = oci_load_balancer.sales_lb_staging.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.sales_bs_staging.name
  port                     = 80
  protocol                 = "HTTP"
}

resource "oci_load_balancer_backend" "sales_bb_staging_1" {
  load_balancer_id = oci_load_balancer.sales_lb_staging.id
  backendset_name  = oci_load_balancer_backend_set.sales_bs_staging.name
  ip_address       = oci_core_instance.sales_staging_instance[0].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "sales_bb_staging_2" {
  load_balancer_id = oci_load_balancer.sales_lb_staging.id
  backendset_name  = oci_load_balancer_backend_set.sales_bs_staging.name
  ip_address       = oci_core_instance.sales_staging_instance[1].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

# Sales-LB-Dev

resource "oci_load_balancer" "sales_lb_dev" {
  shape          = "100Mbps"
  compartment_id = oci_identity_compartment.level41.id

  subnet_ids = [
    oci_core_subnet.public_dev_sales[0].id,
  ]

  display_name = "sales-dev-load-balancer"
}

resource "oci_load_balancer_backend_set" "sales_bs_dev" {
  name             = "sales-backend-dev"
  load_balancer_id = oci_load_balancer.sales_lb_dev.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "5000"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
    interval_ms         = "10000"
    return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_listener" "sales_ll_dev" {
  load_balancer_id         = oci_load_balancer.sales_lb_dev.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.sales_bs_dev.name
  port                     = 80
  protocol                 = "HTTP"
}

resource "oci_load_balancer_backend" "sales_bb_dev_1" {
  load_balancer_id = oci_load_balancer.sales_lb_dev.id
  backendset_name  = oci_load_balancer_backend_set.sales_bs_dev.name
  ip_address       = oci_core_instance.sales_dev_instance[0].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "sales_bb_dev_2" {
  load_balancer_id = oci_load_balancer.sales_lb_dev.id
  backendset_name  = oci_load_balancer_backend_set.sales_bs_dev.name
  ip_address       = oci_core_instance.sales_dev_instance[1].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "sales_bb_dev_3" {
  load_balancer_id = oci_load_balancer.sales_lb_dev.id
  backendset_name  = oci_load_balancer_backend_set.sales_bs_dev.name
  ip_address       = oci_core_instance.sales_dev_instance[2].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}


# Sales-LB-Test

resource "oci_load_balancer" "sales_lb_test" {
  shape          = "100Mbps"
  compartment_id = oci_identity_compartment.level51.id

  subnet_ids = [
    oci_core_subnet.public_test_sales[0].id,
  ]

  display_name = "sales-test-load-balancer"
}

resource "oci_load_balancer_backend_set" "sales_bs_test" {
  name             = "sales-backend-test"
  load_balancer_id = oci_load_balancer.sales_lb_test.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "5000"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
    interval_ms         = "10000"
    return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_listener" "sales_ll_test" {
  load_balancer_id         = oci_load_balancer.sales_lb_test.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.sales_bs_test.name
  port                     = 80
  protocol                 = "HTTP"
}

resource "oci_load_balancer_backend" "sales_bb_test_1" {
  load_balancer_id = oci_load_balancer.sales_lb_test.id
  backendset_name  = oci_load_balancer_backend_set.sales_bs_test.name
  ip_address       = oci_core_instance.sales_test_instance[0].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "sales_bb_test_2" {
  load_balancer_id = oci_load_balancer.sales_lb_test.id
  backendset_name  = oci_load_balancer_backend_set.sales_bs_test.name
  ip_address       = oci_core_instance.sales_test_instance[1].private_ip
  port             = 5000
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}