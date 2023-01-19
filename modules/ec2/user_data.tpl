#!/bin/bash

sudo mkdir -p /data
sudo aws s3 cp s3://jenkins-user-data01/ ./data --recursive

sudo chmod +x /data/user_data.sh
sudo chmod +x /data/run.sh
(cd /data/; sudo ./user_data.sh -y >> /data/output.txt)