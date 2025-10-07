<?php

namespace App\DTO;

use Illuminate\Http\Request;

class UpdateClassDTO
{
    public bool $nameWasChanged = false;
    public string $name;

    public static function fromRequest(Request $request): self
    {
        $dto = new self();

        if ($request->has('name')) {
            $dto->nameWasChanged = true;
            $dto->name = $request->get('name');
        }

        return $dto;
    }
}