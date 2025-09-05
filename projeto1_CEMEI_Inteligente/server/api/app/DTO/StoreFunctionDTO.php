<?php

namespace App\DTO;

use App\Http\Requests\V1\StoreFunctionRequest;

class StoreFunctionDTO
{
    public string $name;

    public static function fromRequest(StoreFunctionRequest $request): self
    {
        $dto = new self();
        $dto->name = $request->get('name');

        return $dto;
    }
}