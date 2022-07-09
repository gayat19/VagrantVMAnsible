#!/bin/bash

# COPYING KEY TO NODES
echo "EXECUTING STEP 3 ----> ADDING SSH KEYS"
yum install -y -q sshpass >/dev/null 2>&1
sshpass -p "ansibleadmin" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no acs.example.com:/home/vagrant/.ssh/id_rsa.pub /id_rsa.pub >/dev/null 2>&1
mkdir -p /home/vagrant/.ssh
cat /id_rsa.pub >> /home/vagrant/.ssh/authorized_keys 
chmod 0700 /home/vagrant/.ssh
chmod 0600 /home/vagrant/.ssh/authorized_keys
rm -f /id_rsa.pub
echo "DONE.... "