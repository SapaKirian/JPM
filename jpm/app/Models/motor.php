<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Motor extends Model {
    protected $table = 'motor';
    protected $fillable = [
        'kategori_id','nama_motor','harga','stok','deskripsi','gambar'
    ];

    public function kategori() {
        return $this->belongsTo(Kategori::class);
    }
}
