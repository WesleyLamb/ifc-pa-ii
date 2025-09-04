<?php

namespace App\Repositories\V1;

use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreKidDTO;
use App\DTO\UpdateKidDTO;
use App\Models\Kid;
use App\Repositories\Contracts\V1\KidRepositoryInterface;
use Illuminate\Pagination\LengthAwarePaginator;

class KidRepository implements KidRepositoryInterface
{
    public function getAll(FilterDTO $filter, PaginatorDTO $paginator): LengthAwarePaginator
    {
        return Kid::filter($filter)->paginate($paginator->perPage)->withQueryString();
    }

    public function createKid(StoreKidDTO $dto): Kid
    {
        $kid = new Kid();

        $kid->library_identifier = $dto->libraryIdentifier;
        $kid->name = $dto->name;
        $kid->birthday = $dto->birthday;
        $kid->father_name = $dto->fatherName;
        $kid->mother_name = $dto->motherName;
        $kid->cpf = $dto->cpf;
        $kid->turnString = $dto->turn;

        $kid->save();

        return $kid->refresh();
    }

    public function getKidByIdOrFail(string $kidId): Kid
    {
        return Kid::where('uuid', $kidId)->firstOrFail();
    }

    public function updateKid(string $kidId, UpdateKidDTO $dto): Kid
    {
        $kid = $this->getKidByIdOrFail($kidId);

        if ($dto->libraryIdentifierWasChanged)
            $kid->library_identifier = $dto->libraryIdentifier;

        if ($dto->nameWasChanged)
            $kid->name = $dto->name;

        if ($dto->birthdayWasChanged)
            $kid->birthday = $dto->birthday;

        if ($dto->fatherNameWasChanged)
            $kid->father_name = $dto->fatherName;

        if ($dto->motherNameWasChanged)
            $kid->mother_name = $dto->motherName;

        if ($dto->cpfWasChanged)
            $kid->cpf = $dto->cpf;

        if ($dto->turnWasChanged)
            $kid->turnString = $dto->turn;

        $kid->save();

        return $kid->refresh();
    }

    public function deleteKid(string $kidId): void
    {
        $kid = $this->getKidByIdOrFail($kidId);
        $kid->delete();
    }
}