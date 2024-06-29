# Gateway Config
resource "aws_api_gateway_rest_api" "static_website_api" {
  name        = "StaticWebsiteAPI"
  description = "API for Static Website"
}