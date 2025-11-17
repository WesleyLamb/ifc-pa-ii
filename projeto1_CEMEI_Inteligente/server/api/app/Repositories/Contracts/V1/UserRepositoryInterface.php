<?php

namespace App\Repositories\Contracts\V1;

use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreUserDTO;
use App\DTO\UpdateUserDTO;
use App\Models\User;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;

interface UserRepositoryInterface
{
    public function getAll(FilterDTO $filter, PaginatorDTO $paginator): LengthAwarePaginator;
    public function createUser(StoreUserDTO $dto): User;
    public function getByIdOrFail(string $userId): User;
    public function getAllByClassId(string $classId, FilterDTO $fitler, PaginatorDTO $paginator): LengthAwarePaginator;
    public function update(string $userId, UpdateUserDTO $dto): User;
}