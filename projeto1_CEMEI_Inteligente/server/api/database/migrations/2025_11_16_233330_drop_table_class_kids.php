<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::dropIfExists('class_kids');
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::create('class_kids', function (Blueprint $table) {
            $table->id();

            $table->foreignId('class_id');
            $table->foreignId('kid_id');

            $table->unique(['class_id', 'kid_id']);
            $table->foreign('class_id')->references('id')->on('classes');
            $table->foreign('kid_id')->references('id')->on('kids');
        });
    }
};
