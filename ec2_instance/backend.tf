terraform {
  backend "s3" {
    bucket       = "akr-terra-501907777143-us-east-1-an"
    key          = "terraform-project-1/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

