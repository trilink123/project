# 🚀 Aurora Resume Agent - Deployment Guide

A comprehensive guide to deploy your AI-powered recruitment system to production servers.

## 📋 Table of Contents

1. [Quick Start](#quick-start)
2. [Prerequisites](#prerequisites)
3. [Environment Configuration](#environment-configuration)
4. [Docker Deployment](#docker-deployment)
5. [Cloud Deployment Options](#cloud-deployment-options)
6. [Security Configuration](#security-configuration)
7. [Monitoring & Maintenance](#monitoring--maintenance)
8. [Troubleshooting](#troubleshooting)

## 🏃‍♂️ Quick Start

### For Windows Users:
```bash
# 1. Configure environment
copy env.production.example .env
# Edit .env with your values

# 2. Deploy
deploy.bat deploy
```

### For Linux/Mac Users:
```bash
# 1. Configure environment
cp env.production.example .env
# Edit .env with your values

# 2. Deploy
chmod +x deploy.sh
./deploy.sh deploy
```

## ✅ Prerequisites

### Required Software:
- **Docker Desktop** (v20.10+) - [Download](https://www.docker.com/products/docker-desktop)
- **Docker Compose** (v2.0+) - Usually included with Docker Desktop
- **Git** (for updates) - [Download](https://git-scm.com/)

### System Requirements:
- **Minimum**: 4GB RAM, 20GB storage, 2 CPU cores
- **Recommended**: 8GB RAM, 50GB storage, 4 CPU cores
- **Operating System**: Windows 10+, macOS 10.14+, Ubuntu 18.04+

### Required Accounts:
- **Google AI API Key** - [Get API Key](https://makersuite.google.com/app/apikey)
- **Domain Name** (for production) - Optional but recommended

## 🔧 Environment Configuration

### 1. Create Environment File
```bash
# Copy the template
cp env.production.example .env
```

### 2. Configure Essential Variables

Edit `.env` file with your values:

```env
# ========================================
# CRITICAL - MUST CONFIGURE THESE
# ========================================

# Your Google AI API Key (REQUIRED)
GOOGLE_API_KEY=your_actual_google_ai_api_key_here

# Strong passwords for security
DB_PASSWORD=your_very_secure_database_password_123!
REDIS_PASSWORD=your_very_secure_redis_password_456!
SECRET_KEY=your_super_secret_jwt_key_at_least_32_characters_long_789!

# Your domain (for production)
ALLOWED_ORIGINS=https://your-domain.com,https://www.your-domain.com
NEXT_PUBLIC_API_URL=https://api.your-domain.com
```

### 3. Security Best Practices

- ✅ Use strong, unique passwords (20+ characters)
- ✅ Never commit `.env` files to version control
- ✅ Rotate secrets regularly
- ✅ Use HTTPS in production
- ✅ Limit CORS origins to your domain only

## 🐳 Docker Deployment

### Local Development Deployment

```bash
# Windows
deploy.bat deploy

# Linux/Mac
./deploy.sh deploy
```

### Production Server Deployment

1. **Prepare Server:**
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add user to docker group
sudo usermod -aG docker $USER
```

2. **Deploy Application:**
```bash
# Clone repository
git clone https://github.com/your-repo/aurora-resume-agent.git
cd aurora-resume-agent

# Configure environment
cp env.production.example .env
nano .env  # Edit with your values

# Deploy
./deploy.sh deploy
```

3. **Access Your Application:**
- Frontend: `http://your-server-ip:3000`
- Backend API: `http://your-server-ip:8000`
- API Documentation: `http://your-server-ip:8000/docs`

### Docker Commands Reference

```bash
# View running services
docker-compose ps

# View logs
docker-compose logs -f [service_name]

# Restart specific service
docker-compose restart backend

# Stop all services
docker-compose down

# Update deployment
git pull
docker-compose build --no-cache
docker-compose up -d
```

## ☁️ Cloud Deployment Options

### 1. Digital Ocean Droplet

**Recommended Configuration:**
- **Size**: 4GB RAM, 2 vCPUs, 80GB SSD ($24/month)
- **OS**: Ubuntu 22.04 LTS

**Quick Deploy:**
```bash
# SSH into droplet
ssh root@your-droplet-ip

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Clone and deploy
git clone https://github.com/your-repo/aurora-resume-agent.git
cd aurora-resume-agent
cp env.production.example .env
# Edit .env with your values
./deploy.sh deploy
```

### 2. AWS EC2 Deployment

**Recommended Instance:**
- **Type**: t3.medium (2 vCPUs, 4GB RAM)
- **Storage**: 30GB GP2 SSD
- **Security Group**: Open ports 22, 80, 443, 3000, 8000

**Deploy Steps:**
```bash
# Connect to EC2
ssh -i your-key.pem ec2-user@your-instance-ip

# Install Docker
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

# Deploy application
git clone https://github.com/your-repo/aurora-resume-agent.git
cd aurora-resume-agent
cp env.production.example .env
# Configure .env
./deploy.sh deploy
```

### 3. Google Cloud Platform (GCP)

**Compute Engine Setup:**
```bash
# Create VM instance
gcloud compute instances create aurora-resume-agent \
    --machine-type=e2-medium \
    --image-family=ubuntu-2004-lts \
    --image-project=ubuntu-os-cloud \
    --boot-disk-size=30GB

# SSH and deploy
gcloud compute ssh aurora-resume-agent
# Follow standard Docker deployment steps
```

### 4. Railway (Simplified Cloud Deployment)

1. Fork the repository to your GitHub
2. Connect Railway to your GitHub account
3. Create new project from your forked repo
4. Set environment variables in Railway dashboard
5. Deploy automatically

### 5. Vercel + Railway Combo

**Frontend (Vercel):**
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy frontend
cd frontend_nextjs
vercel --prod
```

**Backend (Railway):**
- Deploy backend separately on Railway
- Update `NEXT_PUBLIC_API_URL` to Railway backend URL

## 🔒 Security Configuration

### SSL/HTTPS Setup

1. **Get SSL Certificate:**
```bash
# Using Let's Encrypt (free)
sudo apt install certbot
sudo certbot certonly --standalone -d your-domain.com
```

2. **Configure Nginx for HTTPS:**
```bash
# Copy certificates
sudo cp /etc/letsencrypt/live/your-domain.com/fullchain.pem ./ssl/aurora.crt
sudo cp /etc/letsencrypt/live/your-domain.com/privkey.pem ./ssl/aurora.key

# Update nginx.conf
# Uncomment HTTPS server block
# Update server_name to your domain

# Restart
docker-compose restart nginx
```

### Firewall Setup

```bash
# Ubuntu/Debian
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable

# CentOS/RHEL
sudo firewall-cmd --permanent --add-port=22/tcp
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload
```

## 📊 Monitoring & Maintenance

### Health Monitoring

```bash
# Check system health
./deploy.sh health

# View detailed logs
./deploy.sh logs backend
./deploy.sh logs frontend
```

### Regular Maintenance

```bash
# Weekly updates
git pull
./deploy.sh update

# Monthly cleanup
./deploy.sh cleanup
docker system prune -a -f

# Backup database
docker exec aurora-postgres pg_dump -U aurora_user aurora_resume_db > backup.sql
```

### Performance Monitoring

Add monitoring tools in `docker-compose.yml`:

```yaml
  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    
  grafana:
    image: grafana/grafana
    ports:
      - "3001:3000"
```

## 🐛 Troubleshooting

### Common Issues

**1. Services Not Starting:**
```bash
# Check logs
docker-compose logs

# Restart services
docker-compose restart

# Rebuild if needed
docker-compose build --no-cache
```

**2. Database Connection Issues:**
```bash
# Check PostgreSQL
docker-compose exec postgres psql -U aurora_user -d aurora_resume_db -c "SELECT 1;"

# Reset database
docker-compose down
docker volume rm aurora_postgres_data
docker-compose up -d
```

**3. Frontend API Connection Issues:**
```bash
# Check backend health
curl http://localhost:8000/health

# Verify CORS settings
# Check ALLOWED_ORIGINS in .env
```

**4. Memory Issues:**
```bash
# Check resource usage
docker stats

# Increase limits in docker-compose.yml
deploy:
  mem_limit: 2g
  cpus: '1.0'
```

### Log Analysis

```bash
# Backend logs
docker-compose logs -f backend | grep ERROR

# Frontend logs
docker-compose logs -f frontend

# Database logs
docker-compose logs -f postgres

# Nginx logs
docker-compose logs -f nginx
```

### Performance Optimization

```bash
# Optimize Docker images
docker-compose build --no-cache

# Clean unused resources
docker system prune -a

# Monitor resource usage
docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
```

## 📞 Support

### Getting Help

1. **Check Logs**: Always start with `docker-compose logs`
2. **Health Check**: Run `./deploy.sh health`
3. **Documentation**: Review this guide thoroughly
4. **Community**: Search for similar issues online

### Useful Commands

```bash
# Complete system reset
docker-compose down --volumes --remove-orphans
docker system prune -a -f
./deploy.sh deploy

# Service-specific restart
docker-compose restart [service_name]

# Enter container for debugging
docker-compose exec backend bash
docker-compose exec frontend sh
```

---

## 🎉 Congratulations!

Your Aurora Resume Agent is now deployed and ready to revolutionize recruitment with AI! 

**Access URLs:**
- 🌐 **Frontend**: `http://your-domain.com`
- 🔧 **API**: `http://your-domain.com/api`
- 📖 **Docs**: `http://your-domain.com/api/docs`

**Next Steps:**
1. Test all agent functionalities
2. Set up SSL certificates for production
3. Configure monitoring and backups
4. Customize branding and content
5. Launch and start recruiting with AI! 🚀
