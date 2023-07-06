resource "azurerm_cdn_profile" "cdnp" {
  name                = "${var.default_prefix}-cdnp"
  location            = var.default_location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "cdne" {
  name                          = "${var.default_prefix}-cdne"
  location                      = var.default_location
  resource_group_name           = azurerm_resource_group.rg.name
  profile_name                  = azurerm_cdn_profile.cdnp.name
  origin_host_header            = azurerm_storage_account.st.primary_web_host
  is_http_allowed               = true
  is_https_allowed              = true
  is_compression_enabled        = true
  content_types_to_compress     = ["text/html", "text/css", "text/javascript", "font/eot", "font/ttf" ,"font/otf", "font/opentype"]
  optimization_type             = "GeneralWebDelivery"
  querystring_caching_behaviour = "IgnoreQueryString"

  origin {
    name      = "${azurerm_storage_account.st.name}-origin"
    host_name = azurerm_storage_account.st.primary_web_host
  }

  global_delivery_rule {
    modify_response_header_action {
      action = "Append"
      name   = "AddDefaultCharset"
      value         = "UTF-8"
    }
  }

  delivery_rule {
    name = "enforceHTTPS"
    order = 1

    request_scheme_condition {
      match_values     = ["HTTP"]
      negate_condition = false
      operator         = "Equal"
    }

    url_redirect_action {
      redirect_type = "PermanentRedirect"
      protocol      = "Https"
      hostname      = ""
    }
  }

  delivery_rule {
    name = "securityHeaders1"
    order = 2

    request_uri_condition {
      operator         = "Any"
      negate_condition = false
    }

    modify_response_header_action {
      action = "Append"
      name   = "Expect-Staple"
      value  = "max-age=31536000; includeSubDomains; preload"
    }

    modify_response_header_action {
      action = "Append"
      name   = "Strict-Transport-Security"
      value  = "max-age=31536000; includeSubDomains; preload;"
    }

    modify_response_header_action {
      action = "Append"
      name   = "X-XSS-Protection"
      value  = "0"
    }

    modify_response_header_action {
      action = "Append"
      name   = "X-Robots-Tag"
      value  = "all"
    }
  }

  delivery_rule {
    name = "securityHeaders2"
    order = 3

    request_uri_condition {
      operator         = "Any"
      negate_condition = false
    }

    modify_response_header_action {
      action = "Append"
      name   = "Permissions-Policy"
      value  = "accelerometer=(), autoplay=(), camera=(), encrypted-media=(), fullscreen=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), midi=(), payment=(), sync-xhr=(), usb=()"
    }

    modify_response_header_action {
      action = "Append"
      name   = "Content-Security-Policy"
      value  = "default-src 'self'; script-src 'self'; img-src 'self'; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; object-src 'none'; font-src https://fonts.gstatic.com data:; connect-src ${var.azure_function_url}"
    }

    modify_response_header_action {
      action = "Append"
      name   = "Referrer-Policy"
      value  = "no-referrer"
    }

    modify_response_header_action {
      action = "Append"
      name   = "X-Content-Type-Options"
      value  = "nosniff"
    }

    modify_response_header_action {
      action = "Append"
      name   = "X-Frame-Options"
      value  = "DENY"
    }
  }
}

resource "azurerm_cdn_endpoint_custom_domain" "cdne-domain" {
  name            = "${var.default_prefix}-cdne-domain"
  host_name       = var.cdne_domain
  cdn_endpoint_id = azurerm_cdn_endpoint.cdne.id

  cdn_managed_https {
	certificate_type = "Dedicated"
	protocol_type    = "ServerNameIndication"
  }
}
