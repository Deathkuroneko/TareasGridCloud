# Configuracion del proveedor AWS
provider "aws" {
    region = "us-east-1" #region donde se deplegaran los recursos
}

#Creamos el security group
resource "aws_security_group" "mi-sg-dl-win" {
      name = "mi-security-group-terraform-win"
      description = "para instancias de terraform en windows"
      vpc_id = "vpc-0faef9fe8b4a0ada4"
      #reglas de entrada para ssh
      ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      #reglas de salida para http
      egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
}

# declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_windows" {
    ami = "ami-0b5f645abc199e666" # Windows
    instance_type = "t3.large" # tipo
    key_name = "mi-primera-llaves-dl" # el par de llaves
    tags = {
      Name = "Mi-instancia-windows-tf" # Nombre de la instancia
    }
    vpc_security_group_ids = [aws_security_group.mi-sg-dl-win.id] #asignamos el security group a la instancia
}