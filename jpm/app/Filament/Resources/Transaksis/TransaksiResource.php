<?php

namespace App\Filament\Resources\Transaksis;

use App\Filament\Resources\Transaksis\Pages\CreateTransaksi;
use App\Filament\Resources\Transaksis\Pages\EditTransaksi;
use App\Filament\Resources\Transaksis\Pages\ListTransaksis;
use App\Models\Transaksi;
use App\Models\Motor;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Tables\Table;
use BackedEnum;
use Filament\Support\Icons\Heroicon;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;

use Filament\Tables\Columns\TextColumn;
use Filament\Actions\EditAction;
use Filament\Actions\DeleteAction;

class TransaksiResource extends Resource
{
    protected static ?string $model = Transaksi::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'id';

    public static function form(Schema $schema): Schema
    {
        return $schema
            ->schema([
                Select::make('motor_id')
                    ->relationship('motor', 'nama_motor')
                    ->required()
                    ->live()                          // ✅ reactive() → live()
                    ->afterStateUpdated(function ($state, callable $set) {
                        $motor = Motor::find($state);
                        if ($motor) {
                            $set('harga', $motor->harga);
                            $set('total', $motor->harga);
                        }
                    }),

                TextInput::make('qty')
                    ->numeric()
                    ->required()
                    ->default(1)
                    ->live()                          // ✅ reactive() → live()
                    ->afterStateUpdated(function ($state, callable $set, callable $get) {
                        $set('total', $state * $get('harga'));
                    }),

                TextInput::make('harga')
                    ->numeric()
                    ->disabled()
                    ->dehydrated(),

                TextInput::make('total')
                    ->numeric()
                    ->disabled()
                    ->dehydrated(),

                Select::make('status')
                    ->options([
                        'pending' => 'Pending',
                        'lunas'   => 'Lunas',
                        'batal'   => 'Batal',
                    ])
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('motor.nama_motor')
                    ->label('Motor')
                    ->searchable(),

                TextColumn::make('qty'),

                TextColumn::make('total')
                    ->money('IDR')
                    ->sortable(),

                TextColumn::make('status')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) { // ✅ colors() → color()
                        'pending' => 'warning',
                        'lunas'   => 'success',
                        'batal'   => 'danger',
                        default   => 'gray',
                    }),

                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable(),
            ])
            ->recordActions([   // ✅ actions() → recordActions()
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
            'index'  => ListTransaksis::route('/'),
            'create' => CreateTransaksi::route('/create'),
            'edit'   => EditTransaksi::route('/{record}/edit'),
        ];
    }
}