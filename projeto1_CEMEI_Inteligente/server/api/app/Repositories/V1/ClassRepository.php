<?php

namespace App\Repositories\V1;

use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreClassDTO;
use App\DTO\UpdateClassDTO;
use App\Models\CEMEIClass;
use App\Repositories\Contracts\V1\ClassRepositoryInterface;
use Illuminate\Pagination\LengthAwarePaginator;

class ClassRepository implements ClassRepositoryInterface
{
    public function getAll(FilterDTO $filter, PaginatorDTO $paginator): LengthAwarePaginator
    {
        return CEMEIClass::filter($filter)->paginate($paginator->perPage)->withQueryString();
    }

    public function createClass(StoreClassDTO $dto): CEMEIClass
    {
        $class = new CEMEIClass();

        $class->name = $dto->name;

        $class->save();

        return $class->refresh();
    }

    public function getClassByIdOrFail(string $classId): CEMEIClass
    {
        return CEMEIClass::where('uuid', $classId)->firstOrFail();
    }

    public function updateClass(string $classId, UpdateClassDTO $dto): CEMEIClass
    {
        $class = $this->getClassByIdOrFail($classId);

        if ($dto->nameWasChanged)
            $class->name = $dto->name;

        $class->save();

        return $class->refresh();
    }

    public function deleteClass(string $classId): void
    {
        $class = $this->getClassByIdOrFail($classId);

        $class->delete();
    }
}