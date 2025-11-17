<?php

namespace App\Services\V1;

use App\DTO\AddKidToClassDTO;
use App\DTO\AddUserToClassDTO;
use App\DTO\DeleteKidFromClassDTO;
use App\DTO\DeleteUserFromClassDTO;
use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreClassDTO;
use App\DTO\UpdateClassDTO;
use App\Http\Requests\V1\AddKidToClassRequest;
use App\Http\Requests\V1\AddUserToClassRequest;
use App\Http\Requests\V1\StoreClassRequest;
use App\Http\Requests\V1\UpdateClassRequest;
use App\Http\Resources\V1\ClassResource;
use App\Http\Resources\V1\ClassSummaryResource;
use App\Http\Resources\V1\KidResource;
use App\Http\Resources\V1\KidSummaryResource;
use App\Http\Resources\V1\UserResource;
use App\Http\Resources\V1\UserSummaryResource;
use App\Repositories\Contracts\V1\ClassRepositoryInterface;
use App\Repositories\Contracts\V1\FunctionRepositoryInterface;
use App\Repositories\Contracts\V1\KidRepositoryInterface;
use App\Repositories\Contracts\V1\UserRepositoryInterface;
use App\Repositories\V1\ClassRepository;
use App\Repositories\V1\FunctionRepository;
use App\Repositories\V1\KidRepository;
use App\Repositories\V1\UserRepository;
use App\Services\Contracts\V1\ClassServiceInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class ClassService implements ClassServiceInterface
{
    protected ClassRepository $classRepository;
    protected KidRepository $kidRepository;
    protected UserRepository $userRepository;
    protected FunctionRepository $functionRepository;

    public function __construct(ClassRepositoryInterface $classRepository, KidRepositoryInterface $kidRepository, UserRepositoryInterface $userRepository, FunctionRepositoryInterface $functionRepository)
    {
        $this->classRepository = $classRepository;
        $this->kidRepository = $kidRepository;
        $this->userRepository = $userRepository;
        $this->functionRepository = $functionRepository;
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

    public function indexKids(Request $request): AnonymousResourceCollection
    {
        return KidSummaryResource::collection($this->kidRepository->getByClassId($request->route('class_id'), FilterDTO::fromRequest($request), PaginatorDTO::fromRequest($request)));
    }

    public function addKid(AddKidToClassRequest $request): KidResource
    {
        $kid = $this->kidRepository->getByIdOrFail($request->get('kid_id'));
        return new KidResource($this->classRepository->addKid($request->route('class_id'), new AddKidToClassDTO($kid)));
    }

    public function deleteKid(Request $request): JsonResponse
    {
        $kid = $this->kidRepository->getByIdOrFail($request->route('kid_id'));
        $this->classRepository->deleteKid($request->route('class_id'), new DeleteKidFromClassDTO($kid));
        return response()->json([], 204);
    }

    public function indexUsers(Request $request): AnonymousResourceCollection
    {
        return UserSummaryResource::collection($this->userRepository->getAllByClassId($request->route('class_id'), FilterDTO::fromRequest($request), PaginatorDTO::fromRequest($request)));
    }

    public function addUser(AddUserToClassRequest $request): UserResource
    {
        $user = $this->userRepository->getByIdOrFail($request->get('user_id'));
        $function = $this->functionRepository->getByIdOrFail($request->get('function_id'));
        return new UserResource($this->classRepository->addUser($request->route('class_id'),new AddUserToClassDTO($user, $function)));
    }

    public function deleteUser(Request $request): JsonResponse
    {
        $user = $this->userRepository->getByIdOrFail($request->route('user_id'));
        $this->classRepository->deleteUser($request->route('class_id'), new DeleteUserFromClassDTO($user));
        return response()->json([], 204);
    }
}