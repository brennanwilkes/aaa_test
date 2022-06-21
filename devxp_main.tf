terraform {
  backend "gcs" {
      bucket = "terraform-state-5m7bmnhw5n6g5qutqujs3u0v88ae4bmm4iw4vuxgwkqxe"
      prefix = "terraform/state"
  }
}





