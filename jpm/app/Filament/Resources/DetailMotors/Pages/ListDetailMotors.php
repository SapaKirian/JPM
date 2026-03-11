<?php

namespace App\Filament\Resources\DetailMotors\Pages;

use App\Filament\Resources\DetailMotors\DetailMotorResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListDetailMotors extends ListRecords
{
    protected static string $resource = DetailMotorResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
