<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('detail_motor', function (Blueprint $table) {
            $table->id();

            $table->unsignedBigInteger('motor_id');
            $table->foreign('motor_id')
                ->references('id')
                ->on('motor')
                ->onDelete('cascade');

            $table->text('mesin');
            $table->text('rangka');
            $table->text('dimensi');
            $table->text('kelistrikan');
            $table->text('daftar_varian');
            $table->text('daftar_harga');
            $table->text('daftar_warna')->nullable();
            $table->string('video_url')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('detail_motor');
    }
};
