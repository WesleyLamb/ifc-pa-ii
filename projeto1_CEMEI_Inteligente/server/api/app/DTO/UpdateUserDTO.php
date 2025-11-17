<?php

namespace App\DTO;

use App\Http\Requests\UpdateUserRequest;
use App\Repositories\Contracts\V1\FunctionRepositoryInterface;
use App\Repositories\V1\FunctionRepository;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\App;

class UpdateUserDTO
{
    public bool $functionsWasChanged = false;
    public Collection $functions;

    public static function fromRequest(UpdateUserRequest $request): self
    {
        /** @var FunctionRepository $functionRepository */
        $functionRepository = App::make(FunctionRepositoryInterface::class);
        $dto = new self();

        if ($dto->functionsWasChanged = $request->has('functions')) {
            $dto->functions = collect();
            foreach ($request->input('functions') as $function) {
                $dto->functions->add($functionRepository->getByIdOrFail($function['id']));
            }
        }

        return $dto;
    }
}