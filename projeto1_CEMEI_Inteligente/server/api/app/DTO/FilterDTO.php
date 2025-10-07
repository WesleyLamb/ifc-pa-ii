<?php

namespace App\DTO;

use Illuminate\Http\Request;

class FilterDTO
{
    public ?string $q;
    public static function fromRequest(Request $request): self
    {
        $dto = new self();

        $dto->q = $request->query('q');
        
        return $dto;
    }
}