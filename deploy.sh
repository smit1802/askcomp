#!/bin/bash

# AskComp Deployment Script
echo "Starting AskComp Deployment..."

# Check if running with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run with sudo for proper service installation"
  exit 1
fi

# Install system dependencies
echo "Installing system dependencies..."
apt-get update
apt-get install -y python3 python3-pip python3-venv nodejs npm

# Setup Backend
echo "Setting up backend..."
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Create systemd service for backend
echo "Creating systemd service for backend..."
cat > /etc/systemd/system/askcomp-backend.service << EOL
[Unit]
Description=AskComp Backend Service
After=network.target

[Service]
User=$(whoami)
WorkingDirectory=$(pwd)
ExecStart=$(pwd)/venv/bin/uvicorn app.main:app --host 0.0.0.0 --port 8000
Restart=always
RestartSec=5
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=askcomp-backend
Environment="PATH=$(pwd)/venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
Environment="DATABASE_URL=sqlite:///./data/askcomp.db"
Environment="OPENAI_API_KEY=your_openai_api_key"

[Install]
WantedBy=multi-user.target
EOL

# Setup Frontend
echo "Setting up frontend..."
cd frontend/askcomp-frontend
npm install
npm run build

# Create systemd service for frontend
echo "Creating systemd service for frontend..."
cat > /etc/systemd/system/askcomp-frontend.service << EOL
[Unit]
Description=AskComp Frontend Service
After=network.target

[Service]
User=$(whoami)
WorkingDirectory=$(pwd)
ExecStart=$(which npm) start
Restart=always
RestartSec=5
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=askcomp-frontend
Environment="NODE_ENV=production"
Environment="NEXT_PUBLIC_BACKEND_URL=http://localhost:8000"

[Install]
WantedBy=multi-user.target
EOL

# Start services
echo "Starting services..."
systemctl daemon-reload
systemctl enable askcomp-backend.service
systemctl enable askcomp-frontend.service
systemctl start askcomp-backend.service
systemctl start askcomp-frontend.service

echo "Deployment complete!"
echo "Backend running at: http://localhost:8000"
echo "Frontend running at: http://localhost:3000"
echo ""
echo "IMPORTANT: Update your OpenAI API key in /etc/systemd/system/askcomp-backend.service"
echo "           then run: sudo systemctl daemon-reload && sudo systemctl restart askcomp-backend" 