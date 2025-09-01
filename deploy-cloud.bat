@echo off
echo ========================================
echo    Aurora Resume Agent - Cloud Deployment
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

REM Check if Git is installed
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Git is not installed. Please install Git first.
    echo Download from: https://git-scm.com/
    pause
    exit /b 1
)

echo ✅ Prerequisites check passed!
echo.

echo Step 2: Installing Railway CLI...
npm install -g @railway/cli
if %errorlevel% neq 0 (
    echo ❌ Failed to install Railway CLI
    pause
    exit /b 1
)

echo ✅ Railway CLI installed!
echo.

echo Step 3: Please login to Railway...
echo A browser window will open for authentication.
railway login

echo.
echo Step 4: Deploying to Railway...
echo.

echo Deploying backend...
cd backend_fastapi
railway up
if %errorlevel% neq 0 (
    echo ❌ Backend deployment failed
    pause
    exit /b 1
)

echo.
echo Deploying frontend...
cd ..\frontend_nextjs
railway up
if %errorlevel% neq 0 (
    echo ❌ Frontend deployment failed
    pause
    exit /b 1
)

echo.
echo ========================================
echo    🎉 Deployment Complete!
echo ========================================
echo.
echo Your Aurora Resume Agent is now deployed!
echo.
echo Check your Railway dashboard for the URLs:
echo - Frontend: https://your-frontend.railway.app
echo - Backend: https://your-backend.railway.app
echo - API Docs: https://your-backend.railway.app/docs
echo.
pause
