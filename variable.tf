variable cidr {
default =  "10.0.0.0/27"
}

variable scidr {
default = "10.0.0.0/28"
}

variable sucidr {
default = "10.0.0.16/28"
}
variable "PUBLIC_KEY_PATH" {
default = "/root/test.pem" # Replace this with a path to your public key
}

variable ami {
default = "ami-0230bd60aa48260c6"
}

variable instancetype {
default = "t2.micro"
}


