#!/bin/bash

###############################################################################
# Jal Jeevan Mission - Quick Run Script
# Starts the platform locally and displays access URLs
###############################################################################

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║      Jal Jeevan Mission - Water Management Platform        ║"
echo "║                    Starting Services...                    ║"
echo "║                                                      -MOQA ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}\n"

# Get project directory
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

# Check if PostgreSQL is running
echo -e "${YELLOW}⏳ Checking PostgreSQL...${NC}"
if ! brew services list | grep postgresql@17 | grep started > /dev/null 2>&1; then
    echo -e "${YELLOW}   Starting PostgreSQL 17...${NC}"
    brew services start postgresql@17
    sleep 3
fi
echo -e "${GREEN}✓ PostgreSQL is running${NC}\n"

# Check if database exists
echo -e "${YELLOW}⏳ Checking database...${NC}"
if ! psql -lqt | cut -d \| -f 1 | grep -qw jal_jeevan_db; then
    echo -e "${YELLOW}   Creating database 'jal_jeevan_db'...${NC}"
    createdb jal_jeevan_db
    psql jal_jeevan_db -c "CREATE EXTENSION IF NOT EXISTS postgis;"
    psql jal_jeevan_db -c "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"
    echo -e "${YELLOW}   Initializing database schema...${NC}"
    psql jal_jeevan_db < backend/database/schema.sql 2>/dev/null || echo "   Schema already exists or error occurred"
fi
echo -e "${GREEN}✓ Database is ready${NC}\n"

# Setup Python virtual environment
echo -e "${YELLOW}⏳ Setting up Python environment...${NC}"
cd backend
if [ ! -d "venv" ]; then
    echo -e "${YELLOW}   Creating virtual environment...${NC}"
    python3 -m venv venv
fi
source venv/bin/activate
echo -e "${YELLOW}   Installing dependencies...${NC}"
pip install -q -r requirements.txt
echo -e "${GREEN}✓ Python environment ready${NC}\n"

# Check if Redis is available (optional)
if command -v redis-server &> /dev/null; then
    if ! pgrep -x redis-server > /dev/null; then
        echo -e "${YELLOW}⏳ Starting Redis (optional)...${NC}"
        redis-server --daemonize yes 2>/dev/null || echo "   Redis not started (optional)"
    fi
fi

# Start backend in background
echo -e "${YELLOW}⏳ Starting FastAPI backend...${NC}"
uvicorn main:app --host 0.0.0.0 --port 8000 > ../logs/backend.log 2>&1 &
BACKEND_PID=$!
echo $BACKEND_PID > ../logs/backend.pid
cd ..

# Wait for backend to start
sleep 3

# Check if backend is running
if curl -s http://localhost:8000/health > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Backend API is running${NC}\n"
else
    echo -e "${YELLOW}⚠ Backend is starting (may take a few more seconds)${NC}\n"
fi

# Start frontend in background
echo -e "${YELLOW}⏳ Starting frontend server...${NC}"
python3 -m http.server 8080 > logs/frontend.log 2>&1 &
FRONTEND_PID=$!
echo $FRONTEND_PID > logs/frontend.pid

sleep 2
echo -e "${GREEN}✓ Frontend server is running${NC}\n"

# Display access information
echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                   🎉 Platform is Running! 🎉               ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}\n"

echo -e "${BOLD}${CYAN}📍 Access URLs:${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}Frontend:${NC}      ${CYAN}http://localhost:8080${NC}"
echo -e "${BOLD}Backend API:${NC}   ${CYAN}http://localhost:8000${NC}"
echo -e "${BOLD}API Docs:${NC}      ${CYAN}http://localhost:8000/docs${NC}"
echo -e "${BOLD}Health Check:${NC}  ${CYAN}http://localhost:8000/health${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

echo -e "${BOLD}${CYAN}🔐 Login Credentials:${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}Username:${NC}      ${YELLOW}admin${NC}"
echo -e "${BOLD}Password:${NC}      ${YELLOW}admin123${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

echo -e "${BOLD}${CYAN}📊 Platform Features:${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "  ${GREEN}✓${NC} Real-time IoT Monitoring (3,450+ sensors)"
echo -e "  ${GREEN}✓${NC} Interactive Geospatial Map"
echo -e "  ${GREEN}✓${NC} ML-Powered Anomaly Detection"
echo -e "  ${GREEN}✓${NC} Analytics Dashboard"
echo -e "  ${GREEN}✓${NC} Grievance Management"
echo -e "  ${GREEN}✓${NC} WebSocket Real-time Updates"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

echo -e "${BOLD}${CYAN}📁 Process Information:${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}Backend PID:${NC}   ${YELLOW}${BACKEND_PID}${NC}"
echo -e "${BOLD}Frontend PID:${NC}  ${YELLOW}${FRONTEND_PID}${NC}"
echo -e "${BOLD}Logs:${NC}          ${YELLOW}./logs/backend.log${NC} & ${YELLOW}./logs/frontend.log${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

echo -e "${BOLD}${CYAN}🛑 To Stop Services:${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "  ${YELLOW}Press Ctrl+C${NC} or run: ${YELLOW}./stop.sh${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

echo -e "${BOLD}${GREEN}🌐 Opening browser...${NC}\n"

# Open browser
sleep 2
if command -v open &> /dev/null; then
    open http://localhost:8080
elif command -v xdg-open &> /dev/null; then
    xdg-open http://localhost:8080
fi

# Keep script running and show logs
echo -e "${YELLOW}📋 Monitoring logs (Press Ctrl+C to stop):${NC}\n"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Function to cleanup on exit
cleanup() {
    echo -e "\n${YELLOW}🛑 Stopping services...${NC}"

    if [ -f logs/backend.pid ]; then
        BACKEND_PID=$(cat logs/backend.pid)
        kill $BACKEND_PID 2>/dev/null || true
        rm logs/backend.pid
        echo -e "${GREEN}✓ Backend stopped${NC}"
    fi

    if [ -f logs/frontend.pid ]; then
        FRONTEND_PID=$(cat logs/frontend.pid)
        kill $FRONTEND_PID 2>/dev/null || true
        rm logs/frontend.pid
        echo -e "${GREEN}✓ Frontend stopped${NC}"
    fi

    echo -e "\n${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║       Platform stopped successfully! Goodbye Cutie!      ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}\n"
    exit 0
}

trap cleanup SIGINT SIGTERM

# Show combined logs
tail -f logs/backend.log logs/frontend.log 2>/dev/null
