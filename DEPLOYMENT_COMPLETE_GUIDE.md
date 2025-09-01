# 🚀 Aurora Resume Agent - Complete Deployment Guide

This guide will walk you through deploying your Aurora Resume Agent both locally and to the cloud.

---

## 🏠 PART 1: LOCAL DEPLOYMENT (5 minutes)

### Prerequisites
- ✅ Docker Desktop installed and running
- ✅ Administrator privileges on Windows

### Step 1: Open Administrator PowerShell
1. **Right-click** on Windows Start button
2. **Click** "Windows PowerShell (Admin)"
3. **Click "Yes"** when UAC prompts you

### Step 2: Navigate to Project
```powershell
cd C:\Users\devas\Downloads\aurora_resume_agent_fullstack_v2
```

### Step 3: Deploy Locally
```powershell
docker compose up -d --build
```

### Step 4: Wait for Completion
- **Building:** 3-5 minutes
- **Look for:** "✔ Container aurora-frontend Started"

### Step 5: Access Your Interface
- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:8000/docs

### Step 6: Verify Deployment
```powershell
# Check running containers
docker compose ps

# View logs if needed
docker compose logs -f
```

---

## ☁️ PART 2: CLOUD DEPLOYMENT (15 minutes)

### Option A: Railway (Recommended)

#### Prerequisites
- ✅ GitHub account
- ✅ Railway account (free at railway.app)
- ✅ Node.js installed

#### Step 1: Create Railway Account
1. Go to [railway.app](https://railway.app)
2. **Sign up** with GitHub
3. **Create new project**

#### Step 2: Deploy Using CLI (Automated)
```powershell
# Run the automated deployment script
.\deploy-cloud.bat
```

#### Step 3: Manual Deployment (Alternative)

**Deploy Backend:**
```powershell
# Install Railway CLI
npm install -g @railway/cli

# Login to Railway
railway login

# Deploy backend
cd backend_fastapi
railway init
railway up
```

**Deploy Frontend:**
```powershell
# Deploy frontend
cd ..\frontend_nextjs
railway init
railway up
```

#### Step 4: Configure Environment Variables

**Backend Variables:**
```env
GOOGLE_API_KEY=AIzaSyB0hNxVjayoxsXWuYa8js0Er_4H-30R-vM
SECRET_KEY=your_super_secret_jwt_key_32_chars_minimum
ENVIRONMENT=production
PORT=8000
HOST=0.0.0.0
DATABASE_URL=${{Postgres.DATABASE_URL}}
REDIS_URL=${{Redis.REDIS_URL}}
ALLOWED_ORIGINS=https://your-frontend.railway.app
```

**Frontend Variables:**
```env
NEXT_PUBLIC_API_URL=https://your-backend.railway.app
NODE_ENV=production
```

### Option B: Vercel (Frontend Only)

#### Step 1: Deploy Frontend
1. Go to [vercel.com](https://vercel.com)
2. **Import** your GitHub repository
3. **Configure** build settings:
   - **Framework Preset:** Next.js
   - **Root Directory:** frontend_nextjs
   - **Build Command:** `npm run build`
   - **Output Directory:** .next

#### Step 2: Configure Environment Variables
Add in Vercel dashboard:
```
NEXT_PUBLIC_API_URL=https://your-backend-url.railway.app
```

---

## 🔧 TROUBLESHOOTING

### Local Deployment Issues

**Docker not running:**
```powershell
# Start Docker Desktop manually
# Check Docker status
docker info
```

**Port conflicts:**
```powershell
# Check what's using ports 3000/8000
netstat -an | findstr ":3000\|:8000"

# Stop conflicting services or change ports in docker-compose.yml
```

**Build failures:**
```powershell
# Clean and rebuild
docker compose down
docker compose up -d --build --force-recreate
```

### Cloud Deployment Issues

**Railway build failures:**
- Check Railway dashboard logs
- Verify `requirements.txt` and `package.json` exist
- Ensure all environment variables are set

**CORS errors:**
- Update `ALLOWED_ORIGINS` in backend environment
- Include both HTTP and HTTPS URLs

**Database connection issues:**
- Verify `DATABASE_URL` is set correctly
- Check if PostgreSQL service is running in Railway

---

## 📊 DEPLOYMENT COMPARISON

| Platform | Difficulty | Cost | Features | Time | Best For |
|----------|------------|------|----------|------|----------|
| **Local** | Easy | Free | Full features | 5 min | Development/Testing |
| **Railway** | Easy | Free tier | Auto-scaling, DB, Redis | 15 min | Production |
| **Vercel** | Easy | Free tier | CDN, analytics | 10 min | Frontend hosting |
| **AWS** | Complex | Paid | Enterprise features | 30 min | Large scale |

---

## 🎯 RECOMMENDED WORKFLOW

### Phase 1: Local Development (Now)
1. **Deploy locally** to test everything works
2. **Verify all agents** are functioning
3. **Test the interface** thoroughly

### Phase 2: Cloud Deployment (Next)
1. **Deploy to Railway** for backend + database
2. **Deploy to Vercel** for frontend (optional)
3. **Configure production** environment
4. **Set up monitoring** and logging

### Phase 3: Production Optimization
1. **Custom domain** setup
2. **SSL certificates** (auto-handled)
3. **Performance monitoring**
4. **Backup strategies**

---

## 🌐 ACCESS URLs

### Local Deployment
- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:8000/docs
- **Health Check:** http://localhost:8000/health

### Railway Deployment
- **Frontend:** https://your-frontend.railway.app
- **Backend:** https://your-backend.railway.app
- **API Docs:** https://your-backend.railway.app/docs

### Vercel Deployment
- **Frontend:** https://your-project.vercel.app

---

## 🔍 MONITORING & MAINTENANCE

### Local Monitoring
```powershell
# View container logs
docker compose logs -f

# Check resource usage
docker stats

# Restart services
docker compose restart
```

### Cloud Monitoring
```powershell
# Railway CLI monitoring
railway logs
railway status

# Vercel monitoring
vercel logs
vercel status
```

---

## 🎉 SUCCESS CHECKLIST

### Local Deployment
- [ ] Docker containers running
- [ ] Frontend accessible at http://localhost:3000
- [ ] Backend API accessible at http://localhost:8000/docs
- [ ] All AI agents functioning
- [ ] Database connected
- [ ] No error messages in logs

### Cloud Deployment
- [ ] Railway services deployed
- [ ] Environment variables configured
- [ ] Database connected
- [ ] Frontend accessible
- [ ] Backend API accessible
- [ ] CORS properly configured
- [ ] SSL certificates working
- [ ] Monitoring set up

---

## 📞 SUPPORT

If you encounter any issues:

1. **Check the logs** using the commands above
2. **Verify environment variables** are set correctly
3. **Ensure all prerequisites** are installed
4. **Check the troubleshooting section** above

For additional help, refer to:
- **Railway Docs:** https://docs.railway.app
- **Vercel Docs:** https://vercel.com/docs
- **Docker Docs:** https://docs.docker.com

---

## 🚀 Ready to Deploy?

Choose your deployment path:

1. **"Deploy locally first"** - Start with local deployment
2. **"Deploy to Railway"** - Go straight to cloud deployment
3. **"Both local and cloud"** - Follow the complete guide above

Your Aurora Resume Agent is ready to revolutionize recruitment! 🎯
