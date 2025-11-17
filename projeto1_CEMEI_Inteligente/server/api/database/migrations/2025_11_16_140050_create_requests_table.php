<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
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
        Schema::create('requests', function (Blueprint $table) {
            $table->id();
            $table->uuid()->default(DB::raw('gen_random_uuid()'));

            $table->foreignId('petitioner_user_id');
            $table->string('type', 20);
            $table->foreignId('kid_id');
            $table->foreignId('class_id');
            $table->foreignId('attendant_user_id')->nullable();
            $table->dateTime('attendant_date')->nullable();

            $table->timestamps();

            $table->foreign('petitioner_user_id')->references('id')->on('users');
            $table->foreign('kid_id')->references('id')->on('kids');
            $table->foreign('class_id')->references('id')->on('classes');
            $table->foreign('attendant_user_id')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('requests');
    }
};
