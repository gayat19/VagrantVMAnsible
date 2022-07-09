# ---------------------------------------------------
# ENABLING SSH AUTHENTICATION
# ---------------------------------------------------
# Enable ssh password authentication
echo "EXECUTING STEP 3 --> ENABLING SSH PASSWORD AUTHENTICATION"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl reload sshd
echo "export TERM=xterm" >> /etc/bashrc
echo "DONE..."

# ---------------------------------------------------
# GENERATING SSH KEYS
# ---------------------------------------------------

echo "EXECUTING STEP 4 --> GENERATING SSH KEYS"
ssh-keygen -q -t rsa -N '' -f /home/vagrant/.ssh/id_rsa 2>/dev/null <<< y >/dev/null 2>&1
chown -R vagrant:vagrant /home/vagrant/.ssh

# Set Root password
echo -e "ansibleadmin\nansibleadmin" | passwd root 

echo "DONE..."

# ---------------------------------------------------
# INSTALLING ANSIBLE
# ---------------------------------------------------
echo "EXECUTING STEP 5 --> INSTALLING ANSIBLE"
yum install epel-release -y -q >/dev/null 2>&1
yum install ansible -y -q >/dev/null 2>&1
echo "DONE...."

# ---------------------------------------------------
# SETTING UP THE HOSTS
# ---------------------------------------------------
echo "EXECUTING STEP 6 --> SETTING UP THE HOST FILE"
cat >>/etc/ansible/hosts<<EOF
[target]
node-01
EOF

# Setting up node-01 specific values
mkdir -p /etc/ansible/host_vars
cat >>/etc/ansible/host_vars/node-01<<EOF
ansible_ssh_host: 172.16.1.101
EOF

# Add more node values here, if required

mkdir -p /etc/ansible/group_vars
cat >>/etc/ansible/group_vars/target<<EOF
ansible_ssh_port: 22
ansible_ssh_user: vagrant
EOF
# deprecation_warnings = True # for removing deprecation warnings
sed -i 's/#deprecation_warnings = True/deprecation_warnings = False/' /etc/ansible/ansible.cfg
echo "DONE...."
