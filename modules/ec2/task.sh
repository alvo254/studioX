#!/bin/bash


sudo apt update -y
sudo apt upgrage -y
sudo apt install fish -y
sudo apt install nfs-common -y
mount -t efs ${efs_file_system_id}:/ /mnt/efs
