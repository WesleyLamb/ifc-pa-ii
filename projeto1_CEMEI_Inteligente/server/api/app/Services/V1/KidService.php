<?php

namespace App\Services\V1;

use App\Http\Requests\V1\StoreKidRequest;
use App\Http\Requests\V1\UpdateKidRequest;
use App\Http\Resources\V1\KidResource;
use App\Repositories\Contracts\V1\KidRepositoryInterface;
use App\Repositories\V1\KidRepository;
use App\Services\Contracts\V1\KidServiceInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Nette\NotImplementedException;

class KidService implements KidServiceInterface
{
    public KidRepository $kidRepository;

    public function __construct(KidRepositoryInterface $kidRepository)
    {
        $this->kidRepository = $kidRepository;
    }

    public function index(Request $request): AnonymousResourceCollection
    {
        throw new NotImplementedException();
        // return KidResource::collection($this->kidRepository->index());
    }

    public function store(StoreKidRequest $request): KidResource
    {
        throw new NotImplementedException();
        // return new KidResource($this->kidRepository->store(StoreKidDTO::fromRequest($request)));
    }

    public function show(Request $request): KidResource
    {
        throw new NotImplementedException();
    }

    public function update(UpdateKidRequest $request): KidResource
    {
        throw new NotImplementedException();
    }

    public function delete(Request $request): JsonResponse
    {
        throw new NotImplementedException();
    }
}