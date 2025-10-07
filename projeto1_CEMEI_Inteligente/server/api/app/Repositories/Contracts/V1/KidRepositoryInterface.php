<?php

namespace App\Repositories\Contracts\V1;

use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreKidDTO;
use App\DTO\UpdateKidDTO;
use App\Models\Kid;
use Illuminate\Pagination\LengthAwarePaginator;

interface KidRepositoryInterface
{
    public function getAll(FilterDTO $filter, PaginatorDTO $paginator): LengthAwarePaginator;
    public function createKid(StoreKidDTO $dto): Kid;
    public function getKidByIdOrFail(string $kidId): Kid;
    public function updateKid(string $kidId, UpdateKidDTO $dto): Kid;
    public function deleteKid(string $kidId): void;

    public function getByClassId(string $classId, FilterDTO $filter, PaginatorDTO $paginator): LengthAwarePaginator;
}