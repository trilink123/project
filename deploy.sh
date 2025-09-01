#!/bin/bash

# Aurora Resume Agent - Deployment Script
# This script automates the deployment process for the Agentic AI system

set -e  # Exit on any error

echo "🚀 Aurora Resume Agent - Deployment Script"
echo "==========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required commands exist
check_requirements() {
    print_status "Checking requirements..."
    
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    
    print_success "Requirements check passed!"
}

# Check if .env file exists
check_env() {
    print_status "Checking environment configuration..."
    
    if [ ! -f ".env" ]; then
        print_warning ".env file not found. Creating from template..."
        if [ -f "env.production.example" ]; then
            cp env.production.example .env
            print_warning "Please edit .env file with your actual configuration values before continuing!"
            print_warning "Especially set your GOOGLE_API_KEY and other sensitive values."
            read -p "Press Enter after you've configured .env file..."
        else
            print_error "Environment template file not found!"
            exit 1
        fi
    fi
    
    print_success "Environment configuration found!"
}

# Build and deploy with Docker Compose
deploy_docker() {
    print_status "Building and deploying with Docker Compose..."
    
    # Build images
    print_status "Building Docker images..."
    docker-compose build --no-cache
    
    # Start services
    print_status "Starting services..."
    docker-compose up -d
    
    # Wait for services to be healthy
    print_status "Waiting for services to be healthy..."
    sleep 10
    
    # Check service health
    if docker-compose ps | grep -q "unhealthy\|Exit"; then
        print_error "Some services failed to start properly!"
        docker-compose logs
        exit 1
    fi
    
    print_success "All services are running!"
}

# Display deployment information
show_deployment_info() {
    print_success "🎉 Deployment Complete!"
    echo ""
    echo "Access your Aurora Resume Agent:"
    echo "================================"
    echo "🌐 Frontend: http://localhost:3000"
    echo "🔧 Backend API: http://localhost:8000"
    echo "📖 API Docs: http://localhost:8000/docs"
    echo "🗄️  Database: localhost:5432"
    echo "🔴 Redis: localhost:6379"
    echo ""
    echo "Service Status:"
    echo "==============="
    docker-compose ps
    echo ""
    echo "To stop services: docker-compose down"
    echo "To view logs: docker-compose logs -f [service_name]"
    echo "To restart: docker-compose restart [service_name]"
}

# Cleanup function
cleanup() {
    print_status "Cleaning up old containers and images..."
    docker-compose down --remove-orphans
    docker system prune -f
    print_success "Cleanup complete!"
}

# Health check function
health_check() {
    print_status "Performing health checks..."
    
    # Check backend health
    if curl -f http://localhost:8000/health >/dev/null 2>&1; then
        print_success "Backend is healthy!"
    else
        print_error "Backend health check failed!"
        return 1
    fi
    
    # Check frontend
    if curl -f http://localhost:3000 >/dev/null 2>&1; then
        print_success "Frontend is healthy!"
    else
        print_error "Frontend health check failed!"
        return 1
    fi
    
    print_success "All health checks passed!"
}

# Main deployment function
main() {
    case "${1:-deploy}" in
        "deploy")
            check_requirements
            check_env
            deploy_docker
            sleep 30  # Wait for services to fully start
            health_check
            show_deployment_info
            ;;
        "cleanup")
            cleanup
            ;;
        "health")
            health_check
            ;;
        "logs")
            docker-compose logs -f "${2:-}"
            ;;
        "restart")
            print_status "Restarting services..."
            docker-compose restart "${2:-}"
            print_success "Services restarted!"
            ;;
        "stop")
            print_status "Stopping services..."
            docker-compose down
            print_success "Services stopped!"
            ;;
        "update")
            print_status "Updating deployment..."
            docker-compose down
            git pull  # Assuming git repo
            docker-compose build --no-cache
            docker-compose up -d
            health_check
            show_deployment_info
            ;;
        *)
            echo "Usage: $0 {deploy|cleanup|health|logs|restart|stop|update}"
            echo ""
            echo "Commands:"
            echo "  deploy   - Deploy the complete system"
            echo "  cleanup  - Clean up old containers and images"
            echo "  health   - Check system health"
            echo "  logs     - View service logs (optionally specify service)"
            echo "  restart  - Restart services (optionally specify service)"
            echo "  stop     - Stop all services"
            echo "  update   - Update and redeploy from latest code"
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"
