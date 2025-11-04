<?php

namespace App\Services\V1;

use App\DTO\StoreUserDTO;
use App\Exceptions\AuthException;
use App\Http\Requests\V1\ForgotPasswordRequest;
use App\Http\Requests\V1\ResetPasswordRequest;
use App\Http\Requests\V1\StoreUserRequest;
use App\Http\Resources\V1\UserResource;
use App\Repositories\Contracts\V1\UserRepositoryInterface;
use App\Repositories\V1\UserRepository;
use App\Services\Contracts\V1\AuthServiceInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Password;
use Nette\NotImplementedException;

class AuthService implements AuthServiceInterface
{
    public UserRepository $userRepository;

    public function __construct(UserRepositoryInterface $userRepository)
    {
        $this->userRepository = $userRepository;
    }

    public function register(StoreUserRequest $request): UserResource
    {
        $user = $this->userRepository->createUser(StoreUserDTO::fromRequest($request));

        return new UserResource($user);
    }

    public function forgotPassword(ForgotPasswordRequest $request): JsonResponse
    {
        // TODO: Verifica se funfa
        $status = Password::sendResetLink($request->only('email'));
        // dd($status);
        // if ($status === Password::RESET_LINK_SENT)

        return response()->json(['message' => __($status)], Password::RESET_LINK_SENT ? 200 : 400);
    }

    public function resetPassword(ResetPasswordRequest $request): JsonResponse
    {
        $status = Password::reset(
            $request->only('email', 'password', 'password_confirmation', 'token'),
            function($user, $password) {
                $user->password = Hash::make($password);

                $user->save();
            }
        );

        return response()->json(['message' => __($status)], $status == Password::PASSWORD_RESET ? 200 : 400);
    }
}