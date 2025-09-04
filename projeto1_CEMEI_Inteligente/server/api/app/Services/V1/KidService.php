<?php

namespace App\Services\V1;

use App\DTO\StoreKidDTO;
use App\DTO\UpdateKidDTO;
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
        return KidResource::collection($this->kidRepository->getAll());
    }

    public function store(StoreKidRequest $request): KidResource
    {
        return new KidResource($this->kidRepository->createKid(StoreKidDTO::fromRequest($request)));
    }

    public function show(Request $request): KidResource
    {
        return new KidResource($this->kidRepository->getKidByIdOrFail($request->route('kid_id')));
    }

    public function update(UpdateKidRequest $request): KidResource
    {
        return new KidResource($this->kidRepository->updateKid($request->route('kid_id'), UpdateKidDTO::fromRequest($request)));
    }

    public function delete(Request $request): JsonResponse
    {
        $this->kidRepository->deleteKid($request->route('kid_id'));
        return response()->json([], 204);
    }
}