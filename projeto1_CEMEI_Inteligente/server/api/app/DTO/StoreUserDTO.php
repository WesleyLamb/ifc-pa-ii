<?php

namespace App\DTO;

use App\Http\Requests\V1\StoreUserRequest;

class StoreUserDTO
{
    public string $name;
    public string $email;
    public string $password;

    public static function fromRequest(StoreUserRequest $request): self
    {
        $dto = new self();

        $dto->name = $request->get('name');
        $dto->email = $request->get('email');
        $dto->password = $request->get('password');

        return $dto;
    }
}