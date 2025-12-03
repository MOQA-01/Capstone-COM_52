# Jal Jeevan Mission - Water Supply Network Management System

## Overview

An integrated geospatial, IoT, and grievance platform for smart water supply network management under the Jal Jeevan Mission ("Har Ghar Jal - Water for All"). This platform provides comprehensive monitoring, management, and analytics for water infrastructure across India.

## Features

### 1. Geospatial Mapping
- Interactive maps with real-time asset tracking
- Pipeline network visualization
- Infrastructure mapping and monitoring
- 125,000+ assets mapped

### 2. IoT Monitoring
- Real-time sensor data collection
- Flow, pressure, and quality monitoring
- Anomaly detection and alerts
- 3,450+ IoT sensors deployed

### 3. Grievance Management
- Streamlined complaint registration
- Real-time tracking and resolution workflow
- Citizen portal for public access
- 15,000+ complaints resolved

### 4. Analytics & Reporting
- Comprehensive dashboards
- Performance metrics and trends
- Data-driven insights
- 98% system uptime

## Technology Stack

### Frontend
- HTML5, CSS3, JavaScript
- Font Awesome icons
- Responsive design
- Interactive maps and visualizations

### Backend
- Python/FastAPI
- RESTful API architecture
- MQTT for IoT communication
- Machine Learning capabilities

### Database
- Geospatial data storage
- Real-time data processing

## Project Structure

```
CODE/
├── index.html              # Landing page with login
├── dashboard.html          # Main dashboard
├── map.html               # Geospatial mapping interface
├── iot-monitoring.html    # IoT sensor monitoring
├── grievances.html        # Complaint management
├── analytics.html         # Analytics and reports
├── citizen-portal.html    # Public citizen portal
├── about.html             # About the platform
├── css/                   # Stylesheets
├── js/                    # JavaScript files
├── assets/                # Images and media
├── backend/               # Python backend
│   ├── main.py           # Main application entry
│   ├── api/              # API endpoints
│   ├── database/         # Database models
│   ├── ml/               # Machine learning modules
│   ├── mqtt/             # IoT communication
│   └── requirements.txt  # Python dependencies
└── logs/                  # Application logs
```

## Getting Started

### Demo Credentials

Access the platform with these demo credentials:

- **Admin**: `admin / admin123` - Full system access
- **Engineer**: `engineer / eng123` - Field operations access
- **Official**: `official / off123` - Monitoring access
- **Citizen**: `citizen / citizen123` - Public view access

### Frontend Setup

1. Open `index.html` in a web browser
2. Use demo credentials to login
3. Navigate through different modules

### Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Configure environment variables:
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

4. Run the application:
   ```bash
   python main.py
   ```

## Key Statistics

- **125,000+** water assets mapped
- **3,450+** IoT sensors deployed
- **15,000+** complaints resolved
- **98%** system uptime

## Documentation

This repository contains the following documentation:

- `Capstone COM_52 Final.pptx` - Final presentation
- `Report_final_COM_52.pdf` - Complete project report
- `Report_Signed-COM_52.pdf` - Signed project report
- `research_Paper-COM_52.pdf` - Research paper
- `Checklist-COM_52.pdf` - Project checklist
- `Submission_proof_Paper-COM_52.pdf` - Submission proof

## Features by User Role

### Admin
- Full system access
- User management
- System configuration
- All modules access

### Engineer
- Field operations
- Asset management
- Maintenance tracking
- Technical monitoring

### Official
- Monitoring and oversight
- Report generation
- Performance analytics
- Decision support

### Citizen
- Complaint registration
- Complaint tracking
- Water quality information
- Public announcements

## Modules

### Dashboard
Central hub showing:
- Key performance indicators
- Real-time statistics
- System health status
- Quick access to all modules

### Geospatial Map
- Interactive map interface
- Asset location tracking
- Pipeline network visualization
- Zone management

### IoT Monitoring
- Real-time sensor data
- Flow and pressure metrics
- Water quality parameters
- Alert management

### Grievance System
- Complaint registration
- Status tracking
- Resolution workflow
- Communication tools

### Analytics
- Usage patterns
- Performance trends
- Predictive insights
- Custom reports

## License

This is a prototype developed for the Jal Jeevan Mission initiative under the Ministry of Jal Shakti, Government of India.

## Contact

For more information about the Jal Jeevan Mission, visit the official government portal or contact the Ministry of Jal Shakti.

---

**Project**: Capstone COM_52
**Year**: 2025
**Platform**: Integrated Water Supply Network Management System
**Initiative**: Jal Jeevan Mission - Har Ghar Jal
