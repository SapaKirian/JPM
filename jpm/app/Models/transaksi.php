<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Transaksi extends Model
{
    protected $table = 'transaksi';

    protected $fillable = [
        'user_id',
        'total_harga',
        'metode_pembayaran',
        'status',
        'tanggal_transaksi',
    ];

    public function user()
    {
        return $this->belongsTo(\App\Models\User::class);
    }
    public function motor()
    {
        return $this->belongsTo(\App\Models\Motor::class);
    }
}
