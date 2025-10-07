<?php

namespace App\Repositories\V1;

use App\DTO\AddKidToClassDTO;
use App\DTO\AddUserToClassDTO;
use App\DTO\DeleteKidFromClassDTO;
use App\DTO\DeleteUserFromClassDTO;
use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreClassDTO;
use App\DTO\UpdateClassDTO;
use App\Models\CEMEIClass;
use App\Models\ClassKid;
use App\Models\ClassUser;
use App\Models\Kid;
use App\Models\User;
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
        $this->getClassByIdOrFail($classId)->delete();
    }

    public function AddKid(string $classId, AddKidToClassDTO $dto): Kid
    {
        $class = $this->getClassByIdOrFail($classId);

        $classKid = new ClassKid();
        $classKid->kid_id = $dto->kid->id;
        $classKid->class_id = $class->id;

        $classKid->save();

        return $dto->kid;
    }

    public function deleteKid(string $classId, DeleteKidFromClassDTO $dto): void
    {
        $class = $this->getClassByIdOrFail($classId);
        $classKid = ClassKid::where('class_id', $class->id)->where('kid_id', $dto->kid->id)->delete();
    }

    public function addUser(string $classId, AddUserToClassDTO $dto): User
    {
        $class = $this->getClassByIdOrFail($classId);

        $classUser = new ClassUser();
        $classUser->class_id = $class->id;
        $classUser->user_id = $dto->user->id;
        $classUser->function_id = $dto->function->id;

        $classUser->save();

        return $dto->user;
    }

    public function deleteUser(string $classId, DeleteUserFromClassDTO $dto): void
    {
        $class = $this->getClassByIdOrFail($classId);
        $classUer = ClassUser::where('class_id', $class->id)->where('user_id', $dto->user->id)->delete();
    }
}