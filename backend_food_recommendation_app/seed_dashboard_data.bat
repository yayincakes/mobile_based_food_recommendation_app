@echo off
echo Seeding Dashboard Foods, Meals, and Ingredients...
echo.

cd /d "%~dp0"

echo Running Laravel seeder...
php artisan db:seed --class=DashboardRecipesSeeder

echo.
echo Dashboard data seeding completed!
echo.
echo Summary:
echo - Filipino recipes with ingredients
echo - Weekly meal plans
echo - All dashboard foods and meals stored in database
echo.
pause
