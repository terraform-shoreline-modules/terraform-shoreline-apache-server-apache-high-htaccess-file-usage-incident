terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "apache_high_htaccess_file_usage_incident" {
  source    = "./modules/apache_high_htaccess_file_usage_incident"

  providers = {
    shoreline = shoreline
  }
}