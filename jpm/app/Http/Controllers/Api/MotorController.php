<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Motor;
use App\Models\Kategori;

class MotorController extends Controller
{
    public function index()
{
    $motors = Motor::with('kategori')
        ->get()
        ->map(function($m) {
            $gambarBase64 = null;
            if ($m->gambar) {
                $path = storage_path('app/public/' . $m->gambar);
                if (file_exists($path)) {
                    $mime = mime_content_type($path);
                    $data = base64_encode(file_get_contents($path));
                    $gambarBase64 = "data:{$mime};base64,{$data}";
                }
            }

            return [
                'id'         => $m->id,
                'nama_motor' => $m->nama_motor,
                'deskripsi'  => $m->deskripsi,
                'gambar'     => $gambarBase64,
                'kategori'   => $m->kategori?->nama_kategori,
            ];
        });

    $kategoris = Kategori::pluck('nama_kategori');

    return response()->json([
        'kategoris' => $kategoris,
        'motors'    => $motors,
    ]);
}

   public function show($id)
{
    $motor = Motor::with(['kategori', 'detailMotor.varianWarnas'])->findOrFail($id);
    
    $detail = $motor->detailMotor;
    $gambarBase64 = null;
    
    if ($motor->gambar) {
        $path = storage_path('app/public/' . $motor->gambar);
        if (file_exists($path)) {
            $mime = mime_content_type($path);
            $data = base64_encode(file_get_contents($path));
            $gambarBase64 = "data:{$mime};base64,{$data}";
        }
    }

    return response()->json([
        'id'          => $motor->id,
        'nama_motor'  => $motor->nama_motor,
        'deskripsi'   => $motor->deskripsi,
        'gambar'      => $gambarBase64,
        'kategori'    => $motor->kategori?->nama_kategori,
        'detail' => $detail ? [
            'mesin'         => $detail->mesin,
            'rangka'        => $detail->rangka,
            'dimensi'       => $detail->dimensi,
            'kelistrikan'   => $detail->kelistrikan,
            'daftar_varian' => $detail->daftar_varian,
            'daftar_harga'  => $detail->daftar_harga,
            'video_url'     => $detail->video_url,
            'varian_warnas' => $detail->varianWarnas->map(function($vw) {
                $gambar = null;
                if ($vw->gambar) {
                    $path = storage_path('app/public/' . $vw->gambar);
                    if (file_exists($path)) {
                        $mime = mime_content_type($path);
                        $data = base64_encode(file_get_contents($path));
                        $gambar = "data:{$mime};base64,{$data}";
                    }
                }
                return [
                    'nama_varian' => $vw->nama_varian,
                    'nama_warna'  => $vw->nama_warna,
                    'gambar'      => $gambar,
                ];
            }),
        ] : null,
    ]);
}
}