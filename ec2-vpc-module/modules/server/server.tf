# Security group

resource "aws_security_group" "sg-group"{
    name = "nodejs_sg"
  vpc_id = var.vpc_id # This should be reference as it is just blank variable, and it will be called in main server module.

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "securrreee"
  }
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
 
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.sg-group.id]
  key_name = "keysix"
 
  tags = {
    "Name" = "SERVER"
  }
 
 # Provisioner is selected below, that is the reason this block is commented. 
/*  user_data = <<-EOF
   #!/bin/bash
   sudo yum update -y
   sudo yum install httpd -y
   sudo systemctl enable httpd
   sudo systemctl start httpd
   echo "<html><body><div>This is a test webserver!</div></body></html>" > /var/www/html/index.html
   EOF*/
}

# Copies the file as the root user using SSH
# Needed to give script to connect to ec2
resource "null_resource" "key" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("keysix.pem")
    host        = aws_instance.web_server.public_ip
  }
  
  # This block is to copy the file in the home dir of the instance
  provisioner "file" {
    source      = "/Users/superrimal/Documents/terraform-main/ec2-vpc-module/modules/server/script.sh"
    destination = "/home/ec2-user/script.sh"

  }

  # This block runs the command in the home dir, first it will change the permissions
  # and then run the script using bash shell

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ec2-user/script.sh",
      "sudo bash /home/ec2-user/script.sh"
    ]
  }
  depends_on = [aws_instance.web_server]
}

# looking up for the amazon_linux
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}