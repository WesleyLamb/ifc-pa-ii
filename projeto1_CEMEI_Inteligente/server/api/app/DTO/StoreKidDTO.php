<?php

namespace App\DTO;

use App\Http\Requests\V1\StoreKidRequest;
use App\Models\CEMEIClass;
use App\Repositories\Contracts\V1\ClassRepositoryInterface;
use App\Repositories\V1\ClassRepository;
use App\Types\KidTurn;
use DateTimeImmutable;
use Illuminate\Support\Facades\App;

class StoreKidDTO
{
    public string $libraryIdentifier;
    public string $name;
    public DateTimeImmutable $birthday;
    public string $fatherName;
    public string $motherName;
    public string $cpf;
    public string $turn;
    public CEMEIClass $class;

    public static function fromRequest(StoreKidRequest $request): self
    {
        /** @var ClassRepository $classRepository */
        $classRepository = App::make(ClassRepositoryInterface::class);

        $dto = new self();

        $dto->libraryIdentifier = $request->get('library_identifier');
        $dto->name = $request->get('name');
        $dto->birthday = new DateTimeImmutable($request->get('birthday'));
        $dto->fatherName = $request->get('father_name');
        $dto->motherName = $request->get('mother_name');
        $dto->cpf = preg_replace('/\D+/', '', $request->get('cpf'));
        $dto->turn = $request->get('turn');
        $dto->class = $classRepository->getClassByIdOrFail($request->input('class.id'));

        return $dto;
    }
}
