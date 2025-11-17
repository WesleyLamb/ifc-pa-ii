<?php

namespace App\DTO;

use App\Http\Requests\V1\StoreRequestRequest;
use App\Models\CEMEIClass;
use App\Models\Kid;
use App\Models\User;
use App\Repositories\Contracts\V1\KidRepositoryInterface;
use App\Repositories\V1\KidRepository;
use Illuminate\Support\Facades\App;

class StoreRequestDTO
{
    public User $petitionerUser;
    public string $type;
    public Kid $kid;
    public CEMEIClass $class;

    public static function fromRequest(StoreRequestRequest $request): self
    {
        /** @var KidRepository $kidRepository */
        $kidRepository = App::make(KidRepositoryInterface::class);

        $dto = new self();

        $dto->petitionerUser = $request->user();
        $dto->type = $request->input('type');
        $dto->kid = $kidRepository->getByLibraryIdentifierOrFail($request->input('kid.library_identifier'));
        $dto->class = $dto->kid->class;

        return $dto;
    }
}