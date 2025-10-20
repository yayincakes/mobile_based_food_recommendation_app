@echo off
echo Checking users in MySQL database...
echo.

REM Check if MySQL is running and accessible
mysql -u root -pQwerty@123 -e "USE food_recommendation; SELECT COUNT(*) as user_count FROM users; SELECT id, name, email, created_at FROM users ORDER BY created_at DESC LIMIT 5;"

if %errorlevel% neq 0 (
    echo.
    echo Error: Could not connect to MySQL database!
    echo Please make sure:
    echo 1. MySQL is running
    echo 2. Database 'food_recommendation' exists
    echo 3. User 'root' has access with password 'Qwerty@123'
    echo.
)

pause
