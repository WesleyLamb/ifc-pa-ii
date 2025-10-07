<?php

namespace App\DTO;

use App\Http\Requests\V1\UpdateFunctionRequest;

class UpdateFunctionDTO
{
    public bool $nameWasChanged = false;
    public string $name;

    public static function fromRequest(UpdateFunctionRequest $request): self
    {
        $dto = new self();

        $dto->nameWasChanged = $request->has('name');
        $dto->name = $request->get('name');

        return $dto;
    }
}