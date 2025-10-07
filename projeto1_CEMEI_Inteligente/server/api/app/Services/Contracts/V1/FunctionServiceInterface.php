<?php

namespace App\Services\Contracts\V1;

use App\Http\Requests\V1\StoreFunctionRequest;
use App\Http\Requests\V1\UpdateFunctionRequest;
use App\Http\Resources\V1\FunctionResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

interface FunctionServiceInterface
{
    public function index(Request $request): AnonymousResourceCollection;
    public function store(StoreFunctionRequest $request): FunctionResource;
    public function show(Request $request): FunctionResource;
    public function update(UpdateFunctionRequest $request): FunctionResource;
    public function delete(Request $request): JsonResponse;
}