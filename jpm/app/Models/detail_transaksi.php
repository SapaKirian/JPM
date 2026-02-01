<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetailTransaksi extends Model
{
    use HasFactory;

    protected $table = 'detail_transaksi';

    protected $fillable = [
        'transaksi_id',
        'motor_id',
        'sparepart_id',
        'qty',
        'harga'
    ];

    // relasi ke transaksi
    public function transaksi()
    {
        return $this->belongsTo(Transaksi::class);
    }

    // relasi ke motor (opsional)
    public function motor()
    {
        return $this->belongsTo(Motor::class);
    }

    // relasi ke sparepart (opsional)
    public function sparepart()
    {
        return $this->belongsTo(Sparepart::class);
    }
}