<?php

namespace App\Repositories\V1;

use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreUserDTO;
use App\DTO\UpdateUserDTO;
use App\Models\User;
use App\Models\UserFunction;
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

    public function update(string $userId, UpdateUserDTO $dto): User
    {
        $user = $this->getByIdOrFail($userId);

        if ($dto->functionsWasChanged) {
            $user->userFunctions()->whereNotIn('function_id', $dto->functions->pluck('id')->toArray())->delete();

            foreach ($dto->functions as $function) {
                if (!$user->userFunctions()->where('function_id', $function['id'])->exists()) {
                    $userFunction = new UserFunction();

                    $userFunction->user_id = $user->id;
                    $userFunction->function_id = $function['id'];

                    $userFunction->save();
                }
            }
        }

        return $user->refresh();
    }
}