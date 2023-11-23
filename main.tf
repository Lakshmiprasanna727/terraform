provider "aws"{
}

resource "aws_vpc" "vpc" {
cidr_block = var.cidr
tags = {
Name = "vpc_one"
}
}

resource "aws_subnet" "private" {
vpc_id = aws_vpc.vpc.id
cidr_block = var.scidr
tags = {
Name = "subnet_one"
}
}

resource "aws_subnet" "public" {
vpc_id = aws_vpc.vpc.id
cidr_block = var.sucidr
tags = {
Name = "subnet_two"
}
}

resource "aws_internet_gateway" "ingate" {
vpc_id = aws_vpc.vpc.id
tags = {
Name = "ig_one"
}
}

resource "aws_route_table" "rt" {
vpc_id = aws_vpc.vpc.id
route {
gateway_id = aws_internet_gateway.ingate.id
cidr_block = "0.0.0.0/0"
}
tags = {
Name = "route1"
}
}

resource "aws_security_group" "asp" {
vpc_id = aws_vpc.vpc.id
name = "securitygrp"
ingress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
tags = {
Name = "group_1"
}
}
#resource "aws_key_pair" "tf-key-pair" {
#key_name = "tf-key-pair"
#public_key = tls_private_key.rsa.public_key_openssh
#}
#resource "tls_private_key" "rsa"{
#algorithm = "RSA"
#rsa_bits  = 4096
#}
#resource "local_file" "tf-key" {
#content  = tls_private_key.rsa.private_key_pem
#filename = "tf-key-pair"
#}

resource "aws_instance" "one" {
ami = var.ami
key_name = aws_key_pair.hello.id
instance_type = var.instancetype
subnet_id = aws_subnet.private.id
vpc_security_group_ids = [aws_security_group.asp.id]
associate_public_ip_address = true

tags = {
Name = "first_instance"
}
}

resource "aws_key_pair" "hello" {
key_name   = "hello-key"
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiwUY33BdsUyAe58ldnyCIgjhEPbjlEF+V5rd+1hGRF4s5iYQmz0bYV2Y74Sb4tkQaOa/7jQJQxoTa5Z3DXLUQaMipynM3sRhgFy3FGnSkGGBXfBpWcLxxW9i0sIKZ5zfh/FNGplofbV6sY3okbS4UAT9+RB6nMK6Y72VbOTLMbyp6jtc/3PztbZ9vI6g4l6uuR8N5XdDhMWKyS3xHXNsCvBA0WysI1ClbZ8yJebG0pigtQHAI3rW2pIPd6zQdVGanpf/CatT9K2A+O5279wp+z3moAnGXiQhAKYftdOVTICRQvodXyBnZheRtZTPAoIUyHvIP5jB6qQ6qD6GpmxFP"
}
