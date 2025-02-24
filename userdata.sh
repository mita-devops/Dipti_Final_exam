#!/bin/bash
# Update package lists
sudo apt update -y

# Install Java (Jenkins dependency)
sudo apt install -y openjdk-11-jdk

# Install Jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update -y
sudo apt install -y jenkins

# Install Docker
sudo apt install -y docker.io

# Add Jenkins user to the Docker group
sudo usermod -aG docker jenkins

# Enable and restart services
sudo systemctl enable jenkins
sudo systemctl restart jenkins
sudo systemctl enable docker
sudo systemctl restart docker

# Create application directory
sudo mkdir -p /var/www/app
sudo chown -R jenkins:docker /var/www/app

# Create docker-compose.yml
cat << 'EOF' | sudo tee /var/www/app/docker-compose.yml
version: '3.8'
services:
  webapp:
    image: nginx:alpine  # Replace with your actual image
    ports:
      - "9097:80"
    volumes:
      - ./app:/usr/share/nginx/html
    restart: unless-stopped
EOF

# Set permissions
sudo chmod -R 775 /var/www/app

# Start application (executed as jenkins user)
sudo -u jenkins bash -c 'cd /var/www/app && docker compose up -d'