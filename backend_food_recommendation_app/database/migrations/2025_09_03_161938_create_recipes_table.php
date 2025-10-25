<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('recipes', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->text('description')->nullable();
            $table->integer('prep_time')->default(0); // in minutes
            $table->integer('cook_time')->default(0); // in minutes
            $table->integer('servings')->default(1);
            $table->string('difficulty')->default('Easy'); // Easy, Medium, Hard
            $table->string('category')->default('Main Course');
            $table->integer('calories_per_serving')->default(0);
            $table->integer('protein_per_serving')->default(0);
            $table->integer('carbs_per_serving')->default(0);
            $table->integer('fat_per_serving')->default(0);
            $table->text('instructions');
            $table->boolean('is_filipino_dish')->default(false);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('recipes');
    }
};
