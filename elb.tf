
# AWS balancer
resource "aws_elb" "elb-web" {
  # balancer name in AWS with a prefix
  name_prefix = "${var.project}-"

  # distributes evenly between all 3 regions
  cross_zone_load_balancing = true

  # subnets where the lb will send traffic
  subnets = ["${aws_subnet.pub1.id}", "${aws_subnet.pub2.id}"]

  # Listener config
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  # sg association 
  security_groups = ["${aws_security_group.elb-sg.id}"]
}
