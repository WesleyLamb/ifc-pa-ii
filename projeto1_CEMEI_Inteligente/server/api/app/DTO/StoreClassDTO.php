<?php

namespace App\DTO;

use Illuminate\Http\Request;

class StoreClassDTO
{
    public string $name;

    public static function fromRequest(Request $request): self
    {
        $dto = new self();
        
        $dto->name = $request->get('name');

        return $dto;
    }
}