<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class sparepart extends Model
{
    
    protected $table = 'sparepart';
    protected $fillable = [
        'kategori_id','nama_sparepart','harga','stok','deskripsi','gambar'
    ];

    public function kategori() {
        return $this->belongsTo(Kategori::class);
    
}
}
