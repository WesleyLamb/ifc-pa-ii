<?php

namespace App\Repositories\Contracts\V1;

use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreClassDTO;
use App\DTO\UpdateClassDTO;
use App\Models\CEMEIClass;
use Illuminate\Pagination\LengthAwarePaginator;

interface ClassRepositoryInterface
{
    public function getAll(FilterDTO $filter, PaginatorDTO $paginator): LengthAwarePaginator;
    public function createClass(StoreClassDTO $dto): CEMEIClass;
    public function getClassByIdOrFail(string $classId): CEMEIClass;
    public function updateClass(string $classId, UpdateClassDTO $dto): CEMEIClass;
    public function deleteClass(string $classId): void;
}