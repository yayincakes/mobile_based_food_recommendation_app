@echo off
echo Starting Laravel Backend Server...
echo.

REM Check if we're in the right directory
if not exist "backend_food_recommendation_app" (
    echo Error: backend_food_recommendation_app directory not found!
    echo Please run this script from the project root directory.
    pause
    exit /b 1
)

REM Navigate to backend directory
cd backend_food_recommendation_app

REM Check if .env file exists
if not exist ".env" (
    echo Error: .env file not found!
    echo Please create .env file from .env.example
    pause
    exit /b 1
)

REM Check if vendor directory exists
if not exist "vendor" (
    echo Installing PHP dependencies...
    composer install
)

REM Start the Laravel server
echo Starting Laravel server on http://localhost:8000
echo Press Ctrl+C to stop the server
echo.
php artisan serve --host=0.0.0.0 --port=8000

pause
