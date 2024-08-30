#!/bin/bash

# Function to display messages
info() {
    echo -e "\n[INFO] $1\n"
}

# Update and Upgrade the System
info "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install Basic Tools
info "Installing basic tools (curl, git, build-essential)..."
sudo apt install -y curl git build-essential

# Set up UFW Firewall
info "Configuring UFW firewall..."
sudo ufw enable
sudo ufw allow OpenSSH
sudo ufw allow 'Apache Full'
sudo ufw status

# Clone the Ansible Playbook Repository
info "Cloning the pratik.yaml Ansible playbook from GitHub..."
git clone https://github.com/tdarkscorpion/pratik.git
cd pratik

# Install Ansible if not already installed
info "Installing Ansible..."
sudo apt install -y ansible

# Run the Ansible Playbook
info "Running the pratik.yaml playbook..."
ansible-playbook pratik.yaml

# Add current user to Docker group
info "Adding the current user to the Docker group..."
sudo usermod -aG docker $USER

# Secure MySQL installation
info "Securing MySQL installation..."
sudo mysql_secure_installation

# Enable Apache Modules
info "Enabling Apache modules..."
sudo a2enmod rewrite
sudo systemctl restart apache2

# Final message
info "Installation and setup complete! Please reboot your system to apply all changes."
