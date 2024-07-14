resource "aws_security_group" "security_vpro" {
  name        = "security_vpro"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vprovpc.id

  tags = {
    Name = "security_vpro"
  }

  ingress {
    from_port        = 22
    to_port          = 22
    ip_protocol       = "tcp"
    cidr_blocks      = ["106.221.211.153/32"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}