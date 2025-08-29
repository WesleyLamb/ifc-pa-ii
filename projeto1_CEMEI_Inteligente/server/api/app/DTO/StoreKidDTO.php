<?php

namespace App\DTO;

use App\Http\Requests\V1\StoreKidRequest;
use App\Types\KidTurn;
use DateTimeImmutable;

class StoreKidDTO
{
    public string $libraryIdentifier;
    public string $name;
    public DateTimeImmutable $birthday;
    public string $fatherName;
    public string $motherName;
    public string $cpf;
    public KidTurn $turn;


    public static function fromRequest(StoreKidRequest $request): self
    {
        $dto = new self();

        $dto->libraryIdentifier = $request->get('library_identifier');
        $dto->name = $request->get('name');
        $dto->birthday = new DateTimeImmutable($request->get('birthday'));
        $dto->fatherName = $request->get('father_name');
        $dto->motherName = $request->get('mother_name');
        $dto->cpf = $request->get('cpf');
        $dto->turn = $request->get('turn');

        return $dto;
    }
}