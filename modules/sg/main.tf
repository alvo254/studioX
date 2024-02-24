resource "aws_security_group" "studioX" {
    name = "studioX"
    vpc_id = var.vpc_id

    ingress = [
        {
            description      = "HTTP"
            from_port        = 0
            to_port          = 0
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
            prefix_list_ids  = []
            security_groups  = []
            self             = false
            ipv6_cidr_blocks = ["::/0"]
        },
        {
            description = "EFS"
            from_port = 2049
            to_port   = 2049
            protocol  = "tcp"
            cidr_blocks      = ["102.216.154.11/32"] //Please change to your own IP address for this to work
            ipv6_cidr_blocks = ["2001:db8::/32"]
            prefix_list_ids  = []
            security_groups  = []
            self = false

        },
        {
            description      = "SSH"
            from_port        = 22
            to_port          = 22
            protocol         = "tcp"
            //The /32 means use a single ip
            cidr_blocks      = ["196.202.217.213/32"] //Please change to your own IP address for this to work
            ipv6_cidr_blocks = ["::/0"]
            prefix_list_ids  = []
            security_groups  = []
            self             = false
        },
    ]
    egress = [
        {
            description      = "outgoing traffic"
            from_port        = 0
            to_port          = 0
            protocol         = "-1"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
            prefix_list_ids  = []
            security_groups  = []
            self             = false
        }
        
    ]
    tags = {
      Name = "studioX-sg"
    }
  
}