<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AdminUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Create admin user
        User::create([
            'name' => 'Admin User',
            'email' => 'admin@fitmeal.com',
            'password' => Hash::make('admin123'),
            'role' => 'admin',
            'is_active' => true,
        ]);

        // Create a regular user for testing
        User::create([
            'name' => 'Test User',
            'email' => 'user@fitmeal.com',
            'password' => Hash::make('user123'),
            'role' => 'user',
            'is_active' => true,
        ]);
    }
}
