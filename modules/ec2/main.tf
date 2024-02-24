data "template_file" "user_data" {
    template = file("${path.module}/task.sh")
    vars = {
      efs_file_system_id = var.efs_file_system_id
    }
}
resource "aws_instance" "studioX" {
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
  
    subnet_id = var.subnet
    key_name = "${aws_key_pair.studiox.key_name }"

    user_data = data.template_file.user_data.rendered
    # vpc_security_group_ids = [aws_security_group.alvo-toast.id]
    vpc_security_group_ids = [var.security_group]


    tags = {
    	Name = "studioX-A"
    }
}

resource "aws_instance" "studioX-B" {
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
  
    subnet_id = var.pub_sub2_id
    key_name = "${aws_key_pair.studiox.key_name }"

    user_data = data.template_file.user_data.rendered
    # vpc_security_group_ids = [aws_security_group.alvo-toast.id]
    vpc_security_group_ids = [var.security_group]


    tags = {
    	Name = "studioX-B"
    }
}

resource "tls_private_key" "RSA" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "studiox" {
    key_name = "studiox"
    public_key = tls_private_key.RSA.public_key_openssh
}

resource "local_file" "studiox-ssh" {
    content = tls_private_key.RSA.private_key_pem
    filename = "studiox.pem"
}