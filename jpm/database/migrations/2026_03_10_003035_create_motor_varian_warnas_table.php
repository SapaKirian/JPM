<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('motor_varian_warnas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('detail_motor_id')
                  ->constrained('detail_motor')  // ✅ FK ke detail_motor, bukan motor_varians
                  ->cascadeOnDelete();
            $table->string('nama_varian');        // ✅ tambah kolom ini
            $table->string('nama_warna');
            $table->string('gambar')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('motor_varian_warnas');
    }
};
