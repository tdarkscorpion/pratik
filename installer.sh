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

# Install VS Code
info "Installing Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

# Install MySQL
info "Installing MySQL Server..."
sudo apt install -y mysql-server

# Install Apache 2.4
info "Installing Apache 2.4..."
sudo apt install -y apache2

# Install PHP 8.2
info "Installing PHP 8.2 and necessary modules..."
sudo apt install -y php8.2 libapache2-mod-php8.2 php8.2-mysql

# Install Docker
info "Installing Docker..."
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Add current user to Docker group
info "Adding the current user to the Docker group..."
sudo usermod -aG docker $USER

# Install UpWork Desktop Application
info "Installing UpWork Desktop application..."
wget -qO - https://debian.upwork.com/upwork.key | sudo apt-key add -
echo "deb [arch=amd64] https://debian.upwork.com/ stable main" | sudo tee /etc/apt/sources.list.d/upwork.list
sudo apt update
sudo apt install -y upwork

# Install FileZilla
info "Installing FileZilla..."
sudo apt install -y filezilla

# Secure MySQL installation
info "Securing MySQL installation..."
sudo mysql_secure_installation

# Enable Apache Modules
info "Enabling Apache modules..."
sudo a2enmod rewrite
sudo systemctl restart apache2

# Final message
info "Installation and setup complete! Please reboot your system to apply all changes."
