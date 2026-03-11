<?php

namespace App\Filament\Resources\DetailMotors;

use App\Filament\Resources\DetailMotors\Pages\CreateDetailMotor;
use App\Filament\Resources\DetailMotors\Pages\EditDetailMotor;
use App\Filament\Resources\DetailMotors\Pages\ListDetailMotors;
use App\Models\DetailMotor;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Schemas\Components\Section;
use Filament\Tables\Table;

use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\Repeater;      // ✅ tambah
use Filament\Forms\Components\FileUpload;    // ✅ tambah

use Filament\Tables\Columns\TextColumn;
use Filament\Actions\EditAction;
use Filament\Actions\DeleteAction;
use Filament\Actions\DeleteBulkAction;

class DetailMotorResource extends Resource
{
    protected static ?string $model = DetailMotor::class;

    protected static string|BackedEnum|null $navigationIcon = 'heroicon-o-document-text';

    protected static ?string $recordTitleAttribute = 'id';

    public static function form(Schema $schema): Schema
    {
        return $schema
            ->schema([
                Section::make('Relasi Motor')
                    ->schema([
                        Select::make('motor_id')
                            ->relationship('motor', 'nama_motor')
                            ->searchable()
                            ->preload()
                            ->required()
                            ->label('Motor'),
                    ]),

                Section::make('Spesifikasi Teknis')
                    ->columns(2)
                    ->schema([
                        Textarea::make('mesin')->rows(3)->required(),
                        Textarea::make('rangka')->rows(3),
                        Textarea::make('dimensi')->rows(3),
                        Textarea::make('kelistrikan')->rows(3),
                    ]),

                Section::make('Varian & Harga')
                    ->columns(2)
                    ->schema([
                        Textarea::make('daftar_varian')
                            ->label('Daftar Tipe')
                            ->placeholder("Special Edition\nHybrid Lux\nHybrid Neo\nHybrid")
                            ->helperText('Pisahkan dengan enter tiap tipe')
                            ->rows(5)
                            ->live(),

                        Textarea::make('daftar_harga')
                            ->label('Daftar Harga')
                            ->placeholder("35000000\n32000000\n30000000\n28000000")
                            ->helperText('Urutan harga sesuai urutan tipe di atas')
                            ->rows(5),

                        TextInput::make('video_url')
                            ->label('URL Video YouTube')
                            ->url()
                            ->placeholder('https://youtube.com/watch?v=...')
                            ->columnSpanFull(),
                    ]),

                // ✅ Section baru untuk gambar per tipe & warna
                Section::make('Tipe & Warna')
                    ->description('Upload gambar untuk setiap kombinasi tipe dan warna')
                    ->schema([
                        Repeater::make('varianWarnas')
                            ->relationship('varianWarnas')
                            ->label('')
                            ->schema([
                                Select::make('nama_varian')
                                    ->label('Tipe')
                                    ->options(function (callable $get) {
                                        // Coba path ini untuk Filament v4/v5
                                        $raw = $get('../daftar_varian')
                                            ?? $get('../../daftar_varian')
                                            ?? $get('daftar_varian');

                                        if (!$raw)
                                            return [];

                                        return collect(explode("\n", $raw))
                                            ->map(fn($v) => trim($v))
                                            ->filter()
                                            ->mapWithKeys(fn($v) => [$v => $v])
                                            ->toArray();
                                    })
                                    ->live()
                                    ->required(),

                                TextInput::make('nama_warna')
                                    ->label('Nama Warna')
                                    ->required()
                                    ->placeholder('Starry Night'),

                                FileUpload::make('gambar')
                                    ->label('Gambar')
                                    ->image()
                                    ->disk('public')
                                    ->directory('motor-varian')
                                    ->imagePreviewHeight('100')
                                    ->columnSpanFull(),
                            ])
                            ->columns(2)
                            ->addActionLabel('+ Tambah Tipe & Warna')
                            ->columnSpanFull(),
                    ]),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('motor.nama_motor')
                    ->label('Motor')
                    ->sortable()
                    ->searchable(),

                TextColumn::make('daftar_varian')
                    ->label('Tipe')
                    ->limit(40),

                TextColumn::make('mesin')
                    ->label('Mesin')
                    ->limit(30),
            ])
            ->recordActions([
                EditAction::make(),
                DeleteAction::make(),
            ])
            ->bulkActions([
                DeleteBulkAction::make(),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => ListDetailMotors::route('/'),
            'create' => CreateDetailMotor::route('/create'),
            'edit' => EditDetailMotor::route('/{record}/edit'),
        ];
    }
}