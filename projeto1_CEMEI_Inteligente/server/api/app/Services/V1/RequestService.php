<?php

namespace App\Services\V1;

use App\DTO\AttendRequestDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreRequestDTO;
use App\Http\Requests\V1\StoreRequestRequest;
use App\Http\Resources\RequestResource;
use App\Repositories\Contracts\V1\RequestRepositoryInterface;
use App\Repositories\V1\RequestRepository;
use App\Services\Contracts\V1\RequestServiceInterface;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class RequestService implements RequestServiceInterface
{
    protected RequestRepository $requestRepository;

    public function __construct(RequestRepositoryInterface $requestRepository)
    {
        $this->requestRepository = $requestRepository;
    }

    public function index(Request $request): AnonymousResourceCollection
    {
        return RequestResource::collection($this->requestRepository->index($request->user()->uuid, PaginatorDTO::fromRequest($request)));
    }

    public function store(StoreRequestRequest $request): RequestResource
    {
        return new RequestResource($this->requestRepository->store(StoreRequestDTO::fromRequest($request)));
    }

    public function attend(Request $request): RequestResource
    {
        return new RequestResource($this->requestRepository->attend($request->route('request_id'), AttendRequestDTO::fromRequest($request)));
    }
}