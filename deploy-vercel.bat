@echo off
echo ========================================
echo    Aurora Resume Agent - Vercel Deployment
echo ========================================
echo.

echo Step 1: Checking prerequisites...
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js is not installed. Please install Node.js first.
    echo Download from: https://nodejs.org/
    pause
    exit /b 1
)

echo ✅ Node.js is installed!
echo.

echo Step 2: Installing Vercel CLI...
npm install -g vercel
if %errorlevel% neq 0 (
    echo ❌ Failed to install Vercel CLI
    pause
    exit /b 1
)

echo ✅ Vercel CLI installed!
echo.

echo Step 3: Preparing for deployment...
echo.

echo Step 4: Deploying to Vercel...
echo A browser window will open for authentication and deployment.
echo.

cd frontend_nextjs
vercel --prod

echo.
echo ========================================
echo    🎉 Deployment Complete!
echo ========================================
echo.
echo Your Aurora Resume Agent is now deployed on Vercel!
echo.
echo Check your Vercel dashboard for the live URL:
echo - Production: https://your-project.vercel.app
echo - Preview: https://your-project-git-main.vercel.app
echo.
echo Remember to:
echo 1. Set environment variables in Vercel dashboard
echo 2. Configure custom domain (optional)
echo 3. Test all AI agents
echo.
pause
