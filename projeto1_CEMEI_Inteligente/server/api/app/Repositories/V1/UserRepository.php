<?php

namespace App\Repositories\V1;

use App\DTO\StoreUserDTO;
use App\Models\User;
use App\Repositories\Contracts\V1\UserRepositoryInterface;
use Illuminate\Support\Facades\Hash;

class UserRepository implements UserRepositoryInterface
{
    public function createUser(StoreUserDTO $dto): User
    {
        $user = new User();
        $user->name = $dto->name;
        $user->email = $dto->email;
        $user->password = Hash::make($dto->password);

        $user->save();

        return $user->refresh();
    }

    public function getByIdOrFail(string $userId): User
    {
        return User::where('uuid', $userId)->firstOrFail();
    }
}