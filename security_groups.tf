resource "aws_security_group" "andrew_sg" {
    name        = "andrews_sg"
    description = "allow ssh"
    vpc_id      = aws_vpc.andrews_vpc.id

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [var.CIDR_BLOCK]
    }

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [var.CIDR_BLOCK]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.CIDR_BLOCK]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [var.CIDR_BLOCK]
    }
    tags = {
        Name = "andrew_sg"
    }
}

resource "aws_security_group" "allow_ssh" {
    name = "allow_ssh"
    description = "Allow SSH traffic"
    vpc_id = aws_vpc.andrews_vpc.id


    ingress {
        description = "allow SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow_ssh"
    }
}

resource "aws_security_group" "allow_ec2_aurora" {
    name = "allow_ec2_aurora"
    description = "Allow EC2 to Aurora traffic"
    vpc_id = aws_vpc.andrews_vpc.id

    ingress {
        description = "allow ec2 to aurora"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow_ssh"
    }
}

resource "aws_security_group" "allow_aurora_access" {
    name        = "allow_aurora_access"
    description = "Allow EC2 to aurora"
    vpc_id = aws_vpc.andrews_vpc.id

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "aurora-stack-allow-aurora-MySQL"
    }
}