# Gateway Resources
resource "aws_api_gateway_resource" "static_website_resource" {
  rest_api_id = aws_api_gateway_rest_api.static_website_api.id
  parent_id   = aws_api_gateway_rest_api.static_website_api.root_resource_id
  path_part   = "static-website"
}

resource "aws_api_gateway_method" "static_website_method" {
  rest_api_id   = aws_api_gateway_rest_api.static_website_api.id
  resource_id   = aws_api_gateway_resource.static_website_resource.id
  http_method   = "GET"
  authorization = "NONE"
}