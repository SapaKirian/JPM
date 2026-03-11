<?php

namespace App\Filament\Resources\Kategoris;

use App\Filament\Resources\Kategoris\Pages\CreateKategori;
use App\Filament\Resources\Kategoris\Pages\EditKategori;
use App\Filament\Resources\Kategoris\Pages\ListKategoris;
use App\Models\Kategori;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Tables\Table;
use BackedEnum;
use Filament\Support\Icons\Heroicon;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;

use Filament\Tables\Columns\TextColumn;
use Filament\Actions\EditAction;   // ✅ NOT Filament\Tables\Actions
use Filament\Actions\DeleteAction; // ✅ NOT Filament\Tables\Actions

class KategoriResource extends Resource
{
    protected static ?string $model = Kategori::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'nama_kategori';

    public static function form(Schema $schema): Schema
    {
        return $schema
            ->schema([
                TextInput::make('nama_kategori')
                    ->required()
                    ->maxLength(255),

                Textarea::make('keterangan')
                    ->columnSpanFull(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('nama_kategori')
                    ->searchable()
                    ->sortable(),

                TextColumn::make('keterangan')
                    ->limit(50),

                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable(),
            ])
            ->recordActions([  // ✅ recordActions, not actions
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
            'index'  => ListKategoris::route('/'),
            'create' => CreateKategori::route('/create'),
            'edit'   => EditKategori::route('/{record}/edit'),
        ];
    }
}