<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Kategori extends Model {
    protected $table = 'kategori';
    protected $fillable = ['nama_kategori','keterangan'];

    public function motor() {
        return $this->hasMany(Motor::class);
    }

    public function sparepart() {
        return $this->hasMany(Sparepart::class);
    }
}
