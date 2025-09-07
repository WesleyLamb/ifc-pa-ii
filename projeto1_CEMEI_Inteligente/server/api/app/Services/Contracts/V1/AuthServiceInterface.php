<?php

namespace App\Services\Contracts\V1;

use App\Http\Requests\V1\ForgotPasswordRequest;
use App\Http\Requests\V1\ResetPasswordRequest;
use App\Http\Requests\V1\StoreUserRequest;
use App\Http\Resources\V1\UserResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

interface AuthServiceInterface
{
    public function register(StoreUserRequest $request): UserResource;
    public function forgotPassword(ForgotPasswordRequest $request): JsonResponse;
    public function resetPassword(ResetPasswordRequest $request): JsonResponse;
}