data "template_file" "user_data" {
  template = file("./modules/ec2/user_data.tpl")
}

resource "aws_launch_configuration" "launch_configuration" {
  name                        = var.ec2_name
  image_id                    = data.aws_ami.linux.id
  key_name                    = aws_key_pair.key_pair.key_name
  instance_type               = var.instance_type
  user_data                   = data.template_file.user_data.rendered
  security_groups             = [aws_security_group.security_group.id]
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.id
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_type = "standard"
    volume_size = 50
  }
}

data "aws_ami" "linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220805.*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["137112412989"]
}

resource "aws_autoscaling_group" "autoscaling_group" {
  depends_on = [aws_launch_configuration.launch_configuration]
  name                 = format("%s-%s", var.ec2_name, "aut-group")  
  launch_configuration = aws_launch_configuration.launch_configuration.name
  vpc_zone_identifier = [element(var.ec2_subnets, 0), element(var.ec2_subnets, 1)]

  min_size             = 1
  max_size             = 1

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_key_pair" "key_pair" {
  key_name   = format("%s-%s", var.ec2_name, "keypair")
  public_key = file("./modules/ec2/id_rsa.pub")
}