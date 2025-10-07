<?php

namespace App\Services\Contracts\V1;

use App\Http\Requests\V1\StoreKidRequest;
use App\Http\Requests\V1\UpdateKidRequest;
use App\Http\Resources\V1\KidResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

interface KidServiceInterface
{
    public function index(Request $request): AnonymousResourceCollection;
    public function store(StoreKidRequest $request): KidResource;
    public function show(Request $request): KidResource;
    public function update(UpdateKidRequest $request): KidResource;
    public function delete(Request $request): JsonResponse;
}