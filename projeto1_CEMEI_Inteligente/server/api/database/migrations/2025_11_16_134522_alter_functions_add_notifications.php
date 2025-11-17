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
        Schema::table('functions', function (Blueprint $table) {
            $table->boolean('notify_escort')->default(false);
            $table->boolean('notify_dispatch')->default(false);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('functions', function (Blueprint $table) {
            $table->dropColumn('notify_escort');
            $table->dropColumn('notify_dispatch');
        });
    }
};
