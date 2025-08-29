<?php

namespace App\Services\V1;

use App\DTO\StoreUserDTO;
use App\Exceptions\AuthException;
use App\Http\Requests\V1\StoreUserRequest;
use App\Http\Resources\V1\UserResource;
use App\Repositories\Contracts\V1\UserRepositoryInterface as V1UserRepositoryInterface;
use App\Repositories\V1\Contracts\UserRepositoryInterface;
use App\Repositories\V1\UserRepository;
use App\Services\Contracts\V1\AuthServiceInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Password;
use Nette\NotImplementedException;

class AuthService implements AuthServiceInterface
{
    public UserRepository $userRepository;

    public function __construct(V1UserRepositoryInterface $userRepository)
    {
        $this->userRepository = $userRepository;
    }

    public function register(StoreUserRequest $request): UserResource
    {
        $user = $this->userRepository->createUser(StoreUserDTO::fromRequest($request));

        return new UserResource($user);
    }

    public function forgotPassword(Request $request): JsonResponse
    {
        // TODO: Verifica se funfa
        $status = Password::sendResetLink($request->only('email'));
        // if ($status === Password::RESET_LINK_SENT)

        return response()->json([], 204);

    }
}