<?php

namespace App\Filament\Resources\DetailMotors\Pages;

use App\Filament\Resources\DetailMotors\DetailMotorResource;
use Filament\Actions\DeleteAction;
use Filament\Resources\Pages\EditRecord;

class EditDetailMotor extends EditRecord
{
    protected static string $resource = DetailMotorResource::class;

    protected function getHeaderActions(): array
    {
        return [
            DeleteAction::make(),
        ];
    }
}
