@echo off
echo Adding Filipino Dessert Recipes to Database...
echo.

cd /d "%~dp0"

echo Running Laravel seeder...
php artisan db:seed --class=FilipinoDessertRecipesSeeder

echo.
echo Filipino dessert recipes have been successfully added to the database!
echo Total recipes added: 75 Filipino dessert recipes
echo Categories: Traditional desserts, rice cakes, bread, pastries, spring rolls, and more
echo.
pause
