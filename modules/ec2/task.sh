#!/bin/bash


sudo apt update -y
sudo apt upgrage -y
sudo apt install fish -y
sudo apt install nfs-common -y
sudo apt install net-tools -y
echo "inside datacync"
sudo mkdir efs
# sudo mount -t efs ${efs_file_system_id}:/ /efs
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${efs_file_system_id}:/ /efs


