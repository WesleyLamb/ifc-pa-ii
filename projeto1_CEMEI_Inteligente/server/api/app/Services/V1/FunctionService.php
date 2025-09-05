<?php

namespace App\Services\V1;

use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreFunctionDTO;
use App\Http\Requests\V1\StoreFunctionRequest;
use App\Http\Resources\V1\FunctionResource;
use App\Http\Resources\V1\FunctionSummaryResource;
use App\Repositories\Contracts\V1\FunctionRepositoryInterface;
use App\Repositories\V1\FunctionRepository;
use App\Services\Contracts\V1\FunctionServiceInterface;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class FunctionService implements FunctionServiceInterface
{
    protected FunctionRepository $functionRepository;

    public function __construct(FunctionRepositoryInterface $functionRepository)
    {
        $this->functionRepository = $functionRepository;
    }

    public function index(Request $request): AnonymousResourceCollection
    {
        return FunctionSummaryResource::collection($this->functionRepository->getAll(FilterDTO::fromRequest($request), PaginatorDTO::fromRequest($request)));
    }

    public function store(StoreFunctionRequest $request): FunctionResource
    {
        return new FunctionResource($this->functionRepository->store(StoreFunctionDTO::fromRequest($request)));
    }
}