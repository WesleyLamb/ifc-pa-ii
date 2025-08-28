<?php

namespace App\Repositories\Contracts\V1;

use App\DTO\StoreUserDTO;
use App\Models\User;

interface UserRepositoryInterface
{
    public function createUser(StoreUserDTO $dto): User;
}