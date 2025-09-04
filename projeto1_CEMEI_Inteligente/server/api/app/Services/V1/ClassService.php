<?php

namespace App\Services\V1;

use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreClassDTO;
use App\DTO\UpdateClassDTO;
use App\Http\Requests\V1\StoreClassRequest;
use App\Http\Requests\V1\UpdateClassRequest;
use App\Http\Resources\V1\ClassResource;
use App\Http\Resources\V1\ClassSummaryResource;
use App\Repositories\Contracts\V1\ClassRepositoryInterface;
use App\Repositories\V1\ClassRepository;
use App\Services\Contracts\V1\ClassServiceInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class ClassService implements ClassServiceInterface
{
    public ClassRepository $classRepository;

    public function __construct(ClassRepositoryInterface $classRepository)
    {
        $this->classRepository = $classRepository;
    }

    public function index(Request $request): AnonymousResourceCollection
    {
        return ClassSummaryResource::collection($this->classRepository->getAll(FilterDTO::fromRequest($request), PaginatorDTO::fromRequest($request)));
    }

    public function store(StoreClassRequest $request): ClassResource
    {
        return new ClassResource($this->classRepository->createClass(StoreClassDTO::fromRequest($request)));
    }

    public function show(Request $request): ClassResource
    {
        return new ClassResource($this->classRepository->getClassByIdOrFail($request->route('class_id')));
    }

    public function update(UpdateClassRequest $request): ClassResource
    {
        return new ClassResource($this->classRepository->updateClass($request->route('class_id'), UpdateClassDTO::fromRequest($request)));
    }

    public function delete(Request $request): JsonResponse
    {
        $this->classRepository->deleteClass($request->route('class_id'));
        return response()->json([], 204);
    }
}