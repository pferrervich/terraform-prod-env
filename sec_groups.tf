# load balancer security group
resource "aws_security_group" "elb-sg" {
  name = "elb-sg"
  # what vpc will be created the sg
  vpc_id = "${aws_vpc.vpc.id}"

  # rules
  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    # this lb is public, so needs the origin cidr to be all
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    # -1 means any protocol
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# web sg
resource "aws_security_group" "web-sg" {
  name   = "web-sg"
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    # connections need to have sg from elb-sg
    security_groups = ["$aws_security_group.elb-sg.id"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# database sg
resource "aws_security_group" "rds-sg" {
  name = "rds-sg"
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    security_groups = ["${aws_security_group.web-sg.id}"]
  }
    egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
