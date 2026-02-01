<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JadwalBengkel extends Model {
    protected $table = 'jadwal_bengkel';
    protected $fillable = ['hari','jam_buka','jam_tutup','status','keterangan'];
}
