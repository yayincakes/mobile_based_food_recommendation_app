<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Recommendation Database Browser</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #2c3e50; text-align: center; margin-bottom: 30px; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: #3498db; color: white; padding: 20px; border-radius: 8px; text-align: center; }
        .stat-number { font-size: 2em; font-weight: bold; }
        .stat-label { font-size: 0.9em; opacity: 0.9; }
        .section { margin-bottom: 30px; }
        .section h2 { color: #34495e; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
        .recipe-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 15px; }
        .recipe-card { border: 1px solid #ddd; border-radius: 8px; padding: 15px; background: #fafafa; }
        .recipe-name { font-weight: bold; color: #2c3e50; margin-bottom: 5px; }
        .recipe-meta { font-size: 0.9em; color: #7f8c8d; }
        .category-badge { display: inline-block; background: #e74c3c; color: white; padding: 2px 8px; border-radius: 12px; font-size: 0.8em; margin-right: 5px; }
        .btn { background: #3498db; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; margin: 5px; }
        .btn:hover { background: #2980b9; }
        .search-box { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🍽️ Food Recommendation Database Browser</h1>
        
        <div class="stats">
            <div class="stat-card">
                <div class="stat-number">{{ $stats['total_recipes'] }}</div>
                <div class="stat-label">Total Recipes</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">{{ $stats['total_ingredients'] }}</div>
                <div class="stat-label">Total Ingredients</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">{{ $stats['categories']->count() }}</div>
                <div class="stat-label">Categories</div>
            </div>
        </div>

        <div class="section">
            <h2>📊 Recipe Categories</h2>
            @foreach($stats['categories'] as $category)
                <div style="margin: 10px 0; padding: 10px; background: #ecf0f1; border-radius: 5px;">
                    <strong>{{ $category->category }}</strong>: {{ $category->count }} recipes
                </div>
            @endforeach
        </div>

        <div class="section">
            <h2>🔍 Quick Access</h2>
            <button class="btn" onclick="loadRecipes()">View All Recipes</button>
            <button class="btn" onclick="loadDesserts()">View Desserts</button>
            <button class="btn" onclick="loadIngredients()">View Ingredients</button>
            <button class="btn" onclick="loadStats()">View Statistics</button>
        </div>

        <div class="section">
            <h2>🔎 Search Recipes</h2>
            <input type="text" class="search-box" id="searchInput" placeholder="Enter recipe name to search..." onkeyup="searchRecipes()">
            <div id="searchResults"></div>
        </div>

        <div class="section">
            <h2>📋 Recipe List</h2>
            <div id="recipeList"></div>
        </div>
    </div>

    <script>
        async function loadRecipes() {
            try {
                const response = await fetch('/recipes');
                const data = await response.json();
                displayRecipes(data.recipes);
            } catch (error) {
                console.error('Error loading recipes:', error);
            }
        }

        async function loadDesserts() {
            try {
                const response = await fetch('/desserts');
                const data = await response.json();
                displayRecipes(data.desserts);
            } catch (error) {
                console.error('Error loading desserts:', error);
            }
        }

        async function loadIngredients() {
            try {
                const response = await fetch('/ingredients');
                const data = await response.json();
                displayIngredients(data.ingredients);
            } catch (error) {
                console.error('Error loading ingredients:', error);
            }
        }

        async function loadStats() {
            try {
                const response = await fetch('/stats');
                const data = await response.json();
                displayStats(data);
            } catch (error) {
                console.error('Error loading stats:', error);
            }
        }

        async function searchRecipes() {
            const searchTerm = document.getElementById('searchInput').value;
            if (searchTerm.length < 2) return;
            
            try {
                const response = await fetch(`/recipes/search/${encodeURIComponent(searchTerm)}`);
                const data = await response.json();
                displayRecipes(data.recipes);
            } catch (error) {
                console.error('Error searching recipes:', error);
            }
        }

        function displayRecipes(recipes) {
            const container = document.getElementById('recipeList');
            container.innerHTML = `
                <div class="recipe-grid">
                    ${recipes.map(recipe => `
                        <div class="recipe-card">
                            <div class="recipe-name">${recipe.name}</div>
                            <div class="recipe-meta">
                                <span class="category-badge">${recipe.category}</span>
                                ${recipe.calories_per_serving} cal | ${recipe.difficulty}
                            </div>
                            <div style="margin-top: 10px; font-size: 0.9em;">
                                <strong>Ingredients:</strong> ${recipe.ingredients.map(ing => ing.name).join(', ')}
                            </div>
                        </div>
                    `).join('')}
                </div>
            `;
        }

        function displayIngredients(ingredients) {
            const container = document.getElementById('recipeList');
            container.innerHTML = `
                <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 10px;">
                    ${ingredients.map(ingredient => `
                        <div style="padding: 10px; background: #f8f9fa; border-radius: 5px; border-left: 4px solid #3498db;">
                            <strong>${ingredient.name}</strong><br>
                            <small>${ingredient.category}</small>
                        </div>
                    `).join('')}
                </div>
            `;
        }

        function displayStats(stats) {
            const container = document.getElementById('recipeList');
            container.innerHTML = `
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px;">
                    <div style="background: #3498db; color: white; padding: 20px; border-radius: 8px; text-align: center;">
                        <div style="font-size: 2em; font-weight: bold;">${stats.total_recipes}</div>
                        <div>Total Recipes</div>
                    </div>
                    <div style="background: #e74c3c; color: white; padding: 20px; border-radius: 8px; text-align: center;">
                        <div style="font-size: 2em; font-weight: bold;">${stats.total_ingredients}</div>
                        <div>Total Ingredients</div>
                    </div>
                    <div style="background: #f39c12; color: white; padding: 20px; border-radius: 8px; text-align: center;">
                        <div style="font-size: 2em; font-weight: bold;">${stats.filipino_dishes}</div>
                        <div>Filipino Dishes</div>
                    </div>
                    <div style="background: #9b59b6; color: white; padding: 20px; border-radius: 8px; text-align: center;">
                        <div style="font-size: 2em; font-weight: bold;">${stats.dessert_recipes}</div>
                        <div>Dessert Recipes</div>
                    </div>
                </div>
            `;
        }

        // Load recipes on page load
        window.onload = function() {
            loadRecipes();
        };
    </script>
</body>
</html>
