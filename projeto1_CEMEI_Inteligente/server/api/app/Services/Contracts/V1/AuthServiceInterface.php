<?php

namespace App\Services\Contracts\V1;

use App\Http\Requests\V1\StoreUserRequest;
use App\Http\Resources\V1\UserResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

interface AuthServiceInterface
{
    public function register(StoreUserRequest $request): UserResource;
    public function forgotPassword(Request $request): JsonResponse;
}