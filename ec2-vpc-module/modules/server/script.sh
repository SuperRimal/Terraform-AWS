# Script to install httpd onto ec2 instance
#!/bin/bash
   sudo yum update -y
   sudo yum install httpd -y
   sudo yum install -y jq
   sudo systemctl enable httpd
   sudo systemctl start httpd
   # sudo echo "<html><body><div>This is a test webserver!</div></body></html>" > /var/www/html/index.html
   echo "Hello Word from $(hostname -f) from the availability zone: $REGION_AV_SCAN" > /var/www/html/index.html