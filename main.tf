terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "terraform-beginner-2023"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
   cloud {
   organization = "terraform-beginner-2023"
   workspaces {
     name = "terra-house-1"
  }
 }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token= var.terratowns_access_token 
}


module "home_flintstones_hosting" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  content_version = var.flintstones.content_version
  public_path = var.flintstones.public_path
}

resource "terratowns_home" "home" {
  name = "The Flintstones"
  description = <<DESCRIPTION
The Flintstones is a classic animated television show that originally aired from 1960 to 1966. It follows the lives of a prehistoric family, the Flintstones, who live in the town of Bedrock. The show is known for its humorous take on modern-day life, using prehistoric versions of technology and everyday items. The main characters include Fred Flintstone, his wife Wilma, their neighbors Barney and Betty Rubble, and their pet dinosaur Dino. The show has become a cultural icon and has been referenced in numerous other works of media.
DESCRIPTION
  domain_name = module.home_flintstones_hosting.domain_name
  town = "video-valley"
  content_version = 1
}