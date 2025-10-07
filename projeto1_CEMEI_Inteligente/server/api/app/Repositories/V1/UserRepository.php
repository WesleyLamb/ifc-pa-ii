<?php

namespace App\Repositories\V1;

use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreUserDTO;
use App\Models\User;
use App\Repositories\Contracts\V1\UserRepositoryInterface;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;

class UserRepository implements UserRepositoryInterface
{
    public function getAll(FilterDTO $filter, PaginatorDTO $paginator): LengthAwarePaginator
    {
        return User::filter($filter)->paginate($paginator->perPage);
    }

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

    public function getAllByClassId(string $classId, FilterDTO $filter, PaginatorDTO $paginator):LengthAwarePaginator
    {
        return User::filter($filter)->whereHas('classes', function($q) use ($classId) {
            $q->where('uuid', $classId);
        })->paginate($paginator->perPage);
    }
}