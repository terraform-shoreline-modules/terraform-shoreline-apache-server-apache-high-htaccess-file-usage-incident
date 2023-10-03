resource "shoreline_notebook" "apache_high_htaccess_file_usage_incident" {
  name       = "apache_high_htaccess_file_usage_incident"
  data       = file("${path.module}/data/apache_high_htaccess_file_usage_incident.json")
  depends_on = [shoreline_action.invoke_disable_htaccess]
}

resource "shoreline_file" "disable_htaccess" {
  name             = "disable_htaccess"
  input_file       = "${path.module}/data/disable_htaccess.sh"
  md5              = filemd5("${path.module}/data/disable_htaccess.sh")
  description      = "Disable the .htaccess file globally: This can be done by modifying the Apache configuration to disallow the use of .htaccess files globally. This will help in reducing the attack surface for the web application."
  destination_path = "/agent/scripts/disable_htaccess.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_disable_htaccess" {
  name        = "invoke_disable_htaccess"
  description = "Disable the .htaccess file globally: This can be done by modifying the Apache configuration to disallow the use of .htaccess files globally. This will help in reducing the attack surface for the web application."
  command     = "`chmod +x /agent/scripts/disable_htaccess.sh && /agent/scripts/disable_htaccess.sh`"
  params      = []
  file_deps   = ["disable_htaccess"]
  enabled     = true
  depends_on  = [shoreline_file.disable_htaccess]
}

