<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Transaksi extends Model
{
    use HasFactory;

    protected $table = 'transaksi';

    protected $fillable = [
        'user_id',
        'total_harga',
        'metode_pembayaran',
        'status',
        'tanggal_transaksi'
    ];

    // relasi ke user
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // relasi ke detail transaksi
    public function detailTransaksi()
    {
        return $this->hasMany(DetailTransaksi::class);
    }
}
