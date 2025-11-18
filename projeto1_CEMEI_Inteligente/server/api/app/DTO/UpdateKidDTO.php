<?php

namespace App\DTO;

use App\Http\Requests\V1\UpdateKidRequest;
use App\Models\CEMEIClass;
use App\Repositories\Contracts\V1\ClassRepositoryInterface;
use App\Repositories\V1\ClassRepository;
use DateTimeImmutable;
use Illuminate\Support\Facades\App;

class UpdateKidDTO
{
    public string $libraryIdentifier;
    public bool $libraryIdentifierWasChanged = false;

    public string $name;
    public bool $nameWasChanged = false;

    public DateTimeImmutable $birthday;
    public bool $birthdayWasChanged = false;

    public string $fatherName;
    public bool $fatherNameWasChanged;

    public string $motherName;
    public bool $motherNameWasChanged = false;

    public string $cpf;
    public bool $cpfWasChanged = false;

    public string $turn;
    public bool $turnWasChanged = false;

    public ?CEMEIClass $class;
    public bool $classIdWasChanged = false;

    public static function fromRequest(UpdateKidRequest $request): self
    {
        /** @var ClassRepository $classRepository */
        $classRepository = App::make(ClassRepositoryInterface::class);

        $dto = new self();

        if ($dto->libraryIdentifierWasChanged = $request->has('library_identifier')) {
            $dto->libraryIdentifier = $request->input('library_identifier');
        }

        if ($dto->nameWasChanged = $request->has('name')) {
            $dto->name = $request->input('name');
        }

        if ($dto->birthdayWasChanged = $request->has('birthday')) {
            $dto->birthday = new DateTimeImmutable($request->input('birthday'));
        }

        if ($dto->fatherNameWasChanged = $request->has('father_name')) {
            $dto->fatherName = $request->input('father_name');
        }

        if ($dto->motherNameWasChanged = $request->has('mother_name')) {
            $dto->motherName = $request->input('mother_name');
        }

        if ($dto->cpfWasChanged = $request->has('cpf')) {
            $dto->cpf = $request->input('cpf');
        }

        if ($dto->turnWasChanged = $request->has('turn')) {
            $dto->turn = $request->input('turn');
        }

        if ($dto->classIdWasChanged = $request->has('class.id')) {
            if ($request->input('class.id')) {
                $dto->class = $classRepository->getClassByIdOrFail($request->input('class.id'));
            } else {
                $dto->class = null;
            }
        }

        return $dto;
    }
}
