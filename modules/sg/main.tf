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
  
}