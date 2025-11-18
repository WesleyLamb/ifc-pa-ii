<?php

namespace App\Repositories\Contracts\V1;

use App\DTO\AddKidToClassDTO;
use App\DTO\AddUserToClassDTO;
use App\DTO\DeleteKidFromClassDTO;
use App\DTO\DeleteUserFromClassDTO;
use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreClassDTO;
use App\DTO\UpdateClassDTO;
use App\Models\CEMEIClass;
use App\Models\Kid;
use App\Models\User;
use Illuminate\Pagination\LengthAwarePaginator;

interface ClassRepositoryInterface
{
    public function getAll(FilterDTO $filter, PaginatorDTO $paginator): LengthAwarePaginator;
    public function createClass(StoreClassDTO $dto): CEMEIClass;
    public function getClassByIdOrFail(string $classId): CEMEIClass;
    public function updateClass(string $classId, UpdateClassDTO $dto): CEMEIClass;
    public function deleteClass(string $classId): void;

    public function addUser(string $classId, AddUserToClassDTO $dto): User;
    public function deleteUser(string $classId, DeleteUserFromClassDTO $dto): void;
}