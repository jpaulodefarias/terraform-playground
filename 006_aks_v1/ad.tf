resource "azuread_application" "example" {
  display_name = var.client_id
}

resource "azuread_service_principal" "example" {
  application_id = azuread_application.example.application_id
}

resource "azuread_service_principal_password" "example" {
  service_principal_id = azuread_service_principal.example.id
  description          = "My managed password"
  value                = var.client_secret
  end_date             = "2099-01-01T01:02:03Z"
}
