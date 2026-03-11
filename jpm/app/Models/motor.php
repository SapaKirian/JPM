<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Motor extends Model
{
    protected $table = 'motor';

    protected $fillable = [
        'kategori_id',
        'nama_motor',
        'deskripsi',
        'gambar',
    ];

    public function kategori()
    {
        return $this->belongsTo(Kategori::class, 'kategori_id');
    }
    public function transaksis()
    {
        return $this->hasMany(Transaksi::class);
    }
    public function detail()
    {
        return $this->hasOne(DetailMotor::class, 'motor_id');
    }
    public function detailMotor()
    {
        return $this->hasOne(DetailMotor::class);
    }
}
