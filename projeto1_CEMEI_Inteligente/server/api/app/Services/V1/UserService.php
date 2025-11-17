<?php

namespace App\Services\V1;

use App\DTO\FilterDTO;
use App\DTO\PaginatorDTO;
use App\DTO\UpdateUserDTO;
use App\Http\Requests\UpdateUserRequest;
use App\Http\Resources\V1\UserResource;
use App\Http\Resources\V1\UserSummaryResource;
use App\Repositories\Contracts\V1\UserRepositoryInterface;
use App\Repositories\V1\UserRepository;
use App\Services\Contracts\V1\UserServiceInterface;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Facades\Auth;

class UserService implements UserServiceInterface
{
    public UserRepository $userRepository;

    protected function convertUserId(string $RouteUserId): string
    {
        return $RouteUserId != 'me' ? $RouteUserId : Auth::user()->uuid;
    }

    public function __construct(UserRepositoryInterface $userRepository)
    {
        $this->userRepository = $userRepository;
    }

    public function index(Request $request): AnonymousResourceCollection
    {
        return UserSummaryResource::collection($this->userRepository->getAll(FilterDTO::fromRequest($request), PaginatorDTO::fromRequest($request)));
    }

    public function show(Request $request): UserResource
    {
        return new UserResource($this->userRepository->getByIdOrFail($this->convertUserId($request->route('user_id'))));
    }

    public function update(UpdateUserRequest $request): UserResource
    {
        return new UserResource($this->userRepository->update($this->convertUserId($request->route('user_id')), UpdateUserDTO::fromRequest($request)));
    }
}