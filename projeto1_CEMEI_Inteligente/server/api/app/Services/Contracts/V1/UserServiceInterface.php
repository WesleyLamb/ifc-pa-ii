<?php

namespace App\Services\Contracts\V1;

use App\Http\Requests\UpdateUserRequest;
use App\Http\Resources\V1\UserResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

interface UserServiceInterface
{
    public function index(Request $request): AnonymousResourceCollection;
    public function show(Request $request): UserResource;
    public function update(UpdateUserRequest $request): UserResource;
}