@echo off
echo Setting up MySQL for Food Recommendation App...
echo.

echo 1. Configuring Laravel for MySQL...
php configure_mysql.php

echo.
echo 2. Generating application key...
php artisan key:generate

echo.
echo 3. Running database migrations...
php artisan migrate

echo.
echo 4. Running database seeders...
php artisan db:seed

echo.
echo 5. Clearing cache...
php artisan config:clear
php artisan cache:clear

echo.
echo Setup complete! 
echo.
echo Next steps:
echo 1. Open MySQL Workbench
echo 2. Run the setup_mysql.sql script to create the database
echo 3. Run the insert_meal_plans_data.sql script to insert sample data
echo 4. Start your Laravel server: php artisan serve
echo.
pause
