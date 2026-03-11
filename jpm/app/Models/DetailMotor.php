<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetailMotor extends Model
{
    use HasFactory;

    protected $table = 'detail_motor';
    protected $fillable = ['motor_id', 'mesin', 'rangka', 'dimensi', 'kelistrikan', 'daftar_varian', 'daftar_harga', 'daftar_warna', 'video_url'];

    public function motor()
    {
        return $this->belongsTo(Motor::class, 'motor_id');
    }
    public function varianWarnas() // ✅ tambahkan ini
    {
        return $this->hasMany(MotorVarianWarna::class);
    }
}
