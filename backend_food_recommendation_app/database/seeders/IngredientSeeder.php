<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Ingredient;

class IngredientSeeder extends Seeder
{
    public function run(): void
    {
        $ingredients = [
            [
                'name' => 'Chicken Breast',
                'category' => 'Meat',
                'description' => 'Lean protein source, high in protein and low in fat',
            ],
            [
                'name' => 'Pork Belly',
                'category' => 'Meat',
                'description' => 'Rich and flavorful cut of pork, high in fat content',
            ],
            [
                'name' => 'Rice',
                'category' => 'Grain',
                'description' => 'Staple grain, high in carbohydrates and energy',
            ],
            [
                'name' => 'Soy Sauce',
                'category' => 'Condiment',
                'description' => 'Salty condiment made from fermented soybeans',
            ],
            [
                'name' => 'Vinegar',
                'category' => 'Condiment',
                'description' => 'Acidic liquid used for flavoring and preservation',
            ],
            [
                'name' => 'Garlic',
                'category' => 'Vegetable',
                'description' => 'Aromatic bulb used for flavoring, has health benefits',
            ],
            [
                'name' => 'Onion',
                'category' => 'Vegetable',
                'description' => 'Aromatic vegetable used as base for many dishes',
            ],
            [
                'name' => 'Tomato',
                'category' => 'Vegetable',
                'description' => 'Juicy fruit used as vegetable, rich in vitamins',
            ],
            [
                'name' => 'Eggplant',
                'category' => 'Vegetable',
                'description' => 'Purple vegetable, good source of fiber and antioxidants',
            ],
            [
                'name' => 'String Beans',
                'category' => 'Vegetable',
                'description' => 'Green beans, high in fiber and vitamins',
            ],
            [
                'name' => 'Beef Sirloin',
                'category' => 'Meat',
                'description' => 'Lean cut of beef, high in protein and iron',
            ],
            [
                'name' => 'Pork Shoulder',
                'category' => 'Meat',
                'description' => 'Tender cut of pork, good for slow cooking',
            ],
            [
                'name' => 'Fish Sauce',
                'category' => 'Condiment',
                'description' => 'Salty liquid made from fermented fish, common in Asian cuisine',
            ],
            [
                'name' => 'Calamansi',
                'category' => 'Fruit',
                'description' => 'Small citrus fruit, very sour and aromatic',
            ],
            [
                'name' => 'Ginger',
                'category' => 'Spice',
                'description' => 'Aromatic root with spicy flavor, has medicinal properties',
            ],
            [
                'name' => 'Coconut Milk',
                'category' => 'Dairy',
                'description' => 'Rich and creamy liquid from coconut, high in fat',
            ],
            [
                'name' => 'Banana',
                'category' => 'Fruit',
                'description' => 'Sweet fruit, high in potassium and natural sugars',
            ],
            [
                'name' => 'Squash',
                'category' => 'Vegetable',
                'description' => 'Orange vegetable, rich in beta-carotene and fiber',
            ],
            [
                'name' => 'Rice Noodles',
                'category' => 'Grain',
                'description' => 'Thin noodles made from rice flour, gluten-free',
            ],
            [
                'name' => 'Cocoa Powder',
                'category' => 'Spice',
                'description' => 'Powdered chocolate, rich in antioxidants and flavor',
            ]
        ];

        foreach ($ingredients as $ingredient) {
            Ingredient::create($ingredient);
        }
    }
}
