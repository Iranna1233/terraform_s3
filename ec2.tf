provider "aws" {
  region     = "ap-south-1"
}

resource "aws_instance" "Demo" {
  ami       = "ami-0e35ddab05955cf57"
  instance_type = "t2.small"
  tags = {
    Name = "Demo"
  }
}

resource "aws_instance" "web-server" {
 ami = "ami-09ba48996007c8b50"
 instance_type  = "t2.small"
}

# Create EBS Volume for Jenkins server
resource "aws_ebs_volume" "Demo-ebs" {
  availability_zone = "ap-south-1a"
  size              = 10

  tags = {
    Name = "Demo-ebs"
  }

   lifecycle {
    prevent_destroy = false
  }
}


# Create Volume attachment resource for Jenkins server
resource "aws_volume_attachment" "Demo-ebs-volume-attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.Demo-ebs.id
  instance_id = aws_instance.Demo.id

   lifecycle {
    prevent_destroy = false
  }
}

# # Create Elastic IP for Bastion host
resource "aws_eip" "Demo-eip" {
    vpc      = true
}

# Create EIP association for associating EIP to Bastion server ##
resource "aws_eip_association" "Demo-eipassociation" {
  instance_id   = aws_instance.Demo.id
  allocation_id = aws_eip.Demo-eip.id

   lifecycle {
    prevent_destroy = false
    ignore_changes = [instance_id]
  }
}
