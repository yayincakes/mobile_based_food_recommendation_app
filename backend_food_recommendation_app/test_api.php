<?php
// Test API endpoints
$baseUrl = 'http://localhost:8000/api';

// Test health endpoint
echo "Testing Health Endpoint:\n";
$healthResponse = file_get_contents($baseUrl . '/health');
echo $healthResponse . "\n\n";

// Test registration endpoint
echo "Testing Registration Endpoint:\n";
$registrationData = [
    'name' => 'Test User',
    'email' => 'test@example.com',
    'password' => 'password123',
    'password_confirmation' => 'password123',
    'gender' => 'Male',
    'height_cm' => 175,
    'weight_kg' => 70,
    'target_weight_kg' => 65,
    'birth_date' => '1990-01-01',
    'activity_level' => 'Moderate',
    'dietary_goal' => 'Weight Loss'
];

$registrationContext = stream_context_create([
    'http' => [
        'method' => 'POST',
        'header' => 'Content-Type: application/json',
        'content' => json_encode($registrationData)
    ]
]);

$registrationResponse = file_get_contents($baseUrl . '/register', false, $registrationContext);
echo $registrationResponse . "\n\n";

// Test recipes endpoint
echo "Testing Recipes Endpoint:\n";
$recipesResponse = file_get_contents($baseUrl . '/recipes');
echo $recipesResponse . "\n";
?>
