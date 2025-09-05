<?php

namespace App\Repositories\Contracts\V1;

use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreFunctionDTO;
use App\Models\CEMEIFunction;
use Illuminate\Pagination\LengthAwarePaginator;

interface FunctionRepositoryInterface
{
    public function getAll(FilterDTO $filter, PaginatorDTO $paginator): LengthAwarePaginator;
    public function store(StoreFunctionDTO $dto): CEMEIFunction;
    public function getByIdOrFail(string $functionId): CEMEIFunction;
}