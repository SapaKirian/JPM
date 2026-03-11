<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MotorVarianWarna extends Model
{
    protected $table = 'motor_varian_warnas';

    protected $fillable = [
        'detail_motor_id', // ✅ FK ke detail_motor
        'nama_varian',     // ✅ tambah ini
        'nama_warna',
        'gambar',
    ];

    public function detailMotor()
    {
        return $this->belongsTo(DetailMotor::class); // ✅ relasi ke DetailMotor
    }
    public function varianWarnas()
    {
        return $this->hasMany(MotorVarianWarna::class);
    }
}