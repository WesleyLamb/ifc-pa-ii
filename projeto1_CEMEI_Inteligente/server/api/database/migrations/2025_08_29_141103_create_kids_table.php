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
        Schema::create('kids', function (Blueprint $table) {
            $table->id();
            $table->uuid()->default(DB::raw('gen_random_uuid()'));
            $table->string('library_identifier');

            $table->string('name');
            $table->date('birthday');
            $table->string('father_name')->nullable();
            $table->string('mother_name')->nullable();
            $table->char('cpf', 11)->nullable();
            $table->char('turn', 1)->comment('1 - Matutino; 2 - Vespertino; 3 - Integral');

            $table->timestamps();
            $table->unique('library_identifier');
            $table->unique('cpf');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('kids');
    }
};
