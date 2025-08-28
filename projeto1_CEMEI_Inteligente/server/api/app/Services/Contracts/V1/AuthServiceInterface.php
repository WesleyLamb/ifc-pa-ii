<?php

namespace App\Services\Contracts\V1;

use App\Http\Resources\V1\UserResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

interface AuthServiceInterface
{
    public function token(Request $request): JsonResponse;
    public function refreshToken(Request $request): JsonResponse;
    public function register(Request $request): UserResource;
    public function forgotPassword(Request $request): JsonResponse;
}