resource "aws_efs_file_system" "custom_efs" {
  creation_token    = "studioX"
  performance_mode  = "generalPurpose"
  encrypted         = true
  throughput_mode   = "bursting"
  
  provisioned_throughput_in_mibps = 0.5 # Change as needed
  

  tags = {
    Name = "studioX"
  }
}
