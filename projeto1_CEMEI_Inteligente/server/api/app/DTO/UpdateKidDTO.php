<?php

namespace App\DTO;

use App\Http\Requests\V1\UpdateKidRequest;
use DateTimeImmutable;

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

    public string $classId;
    public bool $classIdWasChanged = false;

    public static function fromRequest(UpdateKidRequest $request): self
    {
        $dto = new self();

        if ($request->has('library_identifier')) {
            $dto->libraryIdentifierWasChanged = true;
            $dto->libraryIdentifier = $request->get('library_identifier');
        }

        if ($request->has('name')) {
            $dto->nameWasChanged = true;
            $dto->name = $request->get('name');
        }

        if ($request->has('birthday')) {
            $dto->birthdayWasChanged = true;
            $dto->birthday = new DateTimeImmutable($request->get('birthday'));
        }

        if ($request->has('father_name')) {
            $dto->fatherNameWasChanged = true;
            $dto->fatherName = $request->get('father_name');
        }

        if ($request->has('mother_name')) {
            $dto->motherNameWasChanged = true;
            $dto->motherName = $request->get('mother_name');
        }

        if ($request->has('cpf')) {
            $dto->cpfWasChanged = true;
            $dto->cpf = $request->get('cpf');
        }

        if ($request->has('turn')) {
            $dto->turnWasChanged = true;
            $dto->turn = $request->get('turn');
        }

        if ($request->has('class_id')) {
            $dto->classIdWasChanged = true;
            $dto->classId = $request->get('class_id');
        }

        return $dto;
    }
}
