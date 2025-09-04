<?php

namespace App\Services\Contracts\V1;

use App\Http\Requests\V1\StoreClassRequest;
use App\Http\Requests\V1\UpdateClassRequest;
use App\Http\Resources\V1\ClassResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

interface ClassServiceInterface
{
    public function index(Request $request): AnonymousResourceCollection;
    public function store(StoreClassRequest $request): ClassResource;
    public function show(Request $request): ClassResource;
    public function update(UpdateClassRequest $request): ClassResource;
    public function delete(Request $request): JsonResponse;

}