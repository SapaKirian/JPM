<?php

namespace App\Filament\Resources\Motors;

use App\Filament\Resources\Motors\Pages\CreateMotor;
use App\Filament\Resources\Motors\Pages\EditMotor;
use App\Filament\Resources\Motors\Pages\ListMotors;
use App\Models\Motor;

use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Tables\Table;
use BackedEnum;
use Filament\Support\Icons\Heroicon;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\FileUpload;

use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Columns\ImageColumn;
use Filament\Actions\EditAction;
use Filament\Actions\DeleteAction;


class MotorResource extends Resource
{
    protected static ?string $model = Motor::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'nama_motor';

    public static function form(Schema $schema): Schema
    {
        return $schema
            ->schema([
                Select::make('kategori_id')
                    ->label('Kategori')
                    ->relationship('kategori', 'nama_kategori')
                    ->required(),

                TextInput::make('nama_motor')
                    ->required()
                    ->maxLength(255),

                Textarea::make('deskripsi')
                    ->columnSpanFull(),

                FileUpload::make('gambar')
                    ->image()
                    ->disk('public')       // ✅ tambahkan ini dulu
                    ->directory('motor')
                    ->imagePreviewHeight('100')
                    ->columnSpanFull(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                ImageColumn::make('gambar')
                    ->label('Gambar')
                    ->disk('public')    // ✅ tambahkan ini
                    ->square(),

                TextColumn::make('nama_motor')
                    ->searchable()
                    ->sortable(),

                TextColumn::make('kategori.nama_kategori')
                    ->label('Kategori')
                    ->searchable(),

                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable(),
            ])
            ->recordActions([  // ✅
                EditAction::make(),
                DeleteAction::make(),
            ]);
    }

    public static function getRelations(): array
    {
        return [];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListMotors::route('/'),
            'create' => CreateMotor::route('/create'),
            'edit' => EditMotor::route('/{record}/edit'),
        ];
    }
}