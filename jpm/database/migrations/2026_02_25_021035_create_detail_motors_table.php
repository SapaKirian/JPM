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
          
            $table->foreignId('motor_id')->constrained('motor')->onDelete('cascade');

          
            $table->text('mesin');
            $table->text('rangka');
            $table->text('dimensi');
            $table->text('kelistrikan');

        
            $table->text('daftar_varian')->comment('Contoh isi: Hybrid S, Hybrid');
            $table->text('daftar_harga')->comment('Contoh isi: 18900000, 18200000');

           
            $table->text('daftar_warna')->nullable()->comment('Contoh isi: Dark Grey, Silver');

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
