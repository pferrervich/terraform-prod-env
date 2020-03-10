# launch configuration template
resource "aws_launch_configuration" "web-server" {
  name_prefix = "web-server-"
  image_id = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "${var.instance_type}"
  # ssh key to use
  key_name = "aperture"
  security_groups = ["${aws_security_group.web-sg.id}"]
  # launches script which installs php and httpd
  user_data = "${file("templates/userdata.tpl")}"
  # if any change in launch config, before destroying, create a new one
  lifecycle {
    create_before_destroy = true
  }
}

# autoscalling uses configuration templates to start instances
resource "aws_autoscaling_group" "as-web" {
  name = "${aws_launch_configuration.web-server.name}"
  # launches configuration above
  launch_configuration = "${aws_launch_configuration.web-server.name}"
  # only one instance
  max_size = 1
  min_size = 1
  load_balancers = ["${aws_elb.elb-web.id}"]
  # subnets which will be launched
  vpc_zone_identifier = ["${aws_subnet.pub2.id}", "${aws_subnet.pub1.id}"]
  # wait for at least 1 instance to be alive in the lb to give ok
  wait_for_elb_capacity = 1
  tag {
    key = "Name"
    # tag images on launch
    propagate_at_launch = true
    value = "web-server"
  }
  lifecycle {
    create_before_destroy = true
  }
}
