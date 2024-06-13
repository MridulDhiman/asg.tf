#!/bin/bash

# Update and install required packages
sudo apt-get update -y
sudo apt-get install -y nginx nodejs npm

# Setup Nginx
sudo rm /etc/nginx/sites-enabled/default
cat <<EOT >> /etc/nginx/sites-available/default
server {
    listen 80;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Host \$host;
    }
}
EOT
sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
sudo systemctl restart nginx

# Setup Express app
mkdir -p /home/ubuntu/express-app
cd /home/ubuntu/express-app

cat <<EOT >> app.js
const express = require('express');
const app = express();
const port = 3000;

app.get('/health', (req, res) => {
  res.json({ message: "Hello from Launch Template" });
});

app.listen(port, () => {
  console.log(\`App running on port \${port}\`);
});
EOT

cat <<EOT >> package.json
{
  "name": "express-app",
  "version": "1.0.0",
  "description": "Simple Express app",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "express": "^4.17.1"
  }
}
EOT

# Install npm dependencies and start the app
npm install
npm install -g pm2
pm2 start app.js
pm2 startup systemd
pm2 save
pm2 restart all
