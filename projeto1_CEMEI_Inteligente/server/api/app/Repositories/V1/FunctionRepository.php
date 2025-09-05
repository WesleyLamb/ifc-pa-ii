<?php

namespace App\Repositories\V1;

use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreFunctionDTO;
use App\Models\CEMEIFunction;
use App\Repositories\Contracts\V1\FunctionRepositoryInterface;
use Illuminate\Pagination\LengthAwarePaginator;

class FunctionRepository implements FunctionRepositoryInterface
{
    public function getAll(FilterDTO $filter, PaginatorDTO $paginator): LengthAwarePaginator
    {
        return CEMEIFunction::filter($filter)->paginate($paginator->perPage);
    }

    public function store(StoreFunctionDTO $dto): CEMEIFunction
    {
        $function = new CEMEIFunction();
        $function->name = $dto->name;

        $function->save();

        return $function->refresh();
    }

    public function getByIdOrFail(string $functionId): CEMEIFunction
    {
        return CEMEIFunction::where('uuid', $functionId)->firstOrFail();
    }
}