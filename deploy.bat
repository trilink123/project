@echo off
REM Aurora Resume Agent - Windows Deployment Script
REM This script automates the deployment process for the Agentic AI system on Windows

setlocal EnableDelayedExpansion

echo.
echo ===========================================
echo   Aurora Resume Agent - Deployment Script
echo ===========================================
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Docker is not installed. Please install Docker Desktop first.
    echo Download from: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

REM Check if Docker Compose is available
docker compose version >nul 2>&1
if errorlevel 1 (
    docker-compose --version >nul 2>&1
    if errorlevel 1 (
        echo [ERROR] Docker Compose is not available. Please ensure Docker Desktop is running.
        pause
        exit /b 1
    )
    set COMPOSE_CMD=docker-compose
) else (
    set COMPOSE_CMD=docker compose
)

echo [INFO] Docker and Docker Compose are available!

REM Check if .env file exists
if not exist ".env" (
    echo [WARNING] .env file not found. Creating from template...
    if exist "env.production.example" (
        copy "env.production.example" ".env" >nul
        echo [WARNING] Please edit .env file with your actual configuration values!
        echo [WARNING] Especially set your GOOGLE_API_KEY and other sensitive values.
        echo.
        pause
    ) else (
        echo [ERROR] Environment template file not found!
        pause
        exit /b 1
    )
)

echo [INFO] Environment configuration found!

REM Parse command line arguments
set ACTION=%1
if "%ACTION%"=="" set ACTION=deploy

if "%ACTION%"=="deploy" goto :deploy
if "%ACTION%"=="stop" goto :stop
if "%ACTION%"=="restart" goto :restart
if "%ACTION%"=="logs" goto :logs
if "%ACTION%"=="cleanup" goto :cleanup
if "%ACTION%"=="health" goto :health
goto :usage

:deploy
echo [INFO] Building and deploying with Docker Compose...
echo [INFO] Building Docker images...
%COMPOSE_CMD% build --no-cache

echo [INFO] Starting services...
%COMPOSE_CMD% up -d

echo [INFO] Waiting for services to start...
timeout /t 30 /nobreak >nul

echo [INFO] Checking service status...
%COMPOSE_CMD% ps

echo.
echo ===========================================
echo   Deployment Complete!
echo ===========================================
echo.
echo Access your Aurora Resume Agent:
echo   Frontend: http://localhost:3000
echo   Backend API: http://localhost:8000
echo   API Docs: http://localhost:8000/docs
echo   Database: localhost:5432
echo   Redis: localhost:6379
echo.
echo Commands:
echo   deploy.bat stop     - Stop all services
echo   deploy.bat logs     - View logs
echo   deploy.bat restart  - Restart services
echo   deploy.bat cleanup  - Clean up containers
echo.
goto :end

:stop
echo [INFO] Stopping services...
%COMPOSE_CMD% down
echo [INFO] Services stopped!
goto :end

:restart
echo [INFO] Restarting services...
%COMPOSE_CMD% restart
echo [INFO] Services restarted!
goto :end

:logs
echo [INFO] Viewing logs...
%COMPOSE_CMD% logs -f
goto :end

:cleanup
echo [INFO] Cleaning up containers and images...
%COMPOSE_CMD% down --remove-orphans
docker system prune -f
echo [INFO] Cleanup complete!
goto :end

:health
echo [INFO] Checking service health...
curl -f http://localhost:8000/health >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Backend health check failed!
) else (
    echo [SUCCESS] Backend is healthy!
)

curl -f http://localhost:3000 >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Frontend health check failed!
) else (
    echo [SUCCESS] Frontend is healthy!
)
goto :end

:usage
echo Usage: deploy.bat [command]
echo.
echo Commands:
echo   deploy   - Deploy the complete system (default)
echo   stop     - Stop all services
echo   restart  - Restart services
echo   logs     - View service logs
echo   cleanup  - Clean up containers and images
echo   health   - Check system health
echo.

:end
pause
