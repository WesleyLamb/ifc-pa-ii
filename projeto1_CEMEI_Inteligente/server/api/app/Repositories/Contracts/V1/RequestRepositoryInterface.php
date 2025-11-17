<?php

namespace App\Repositories\Contracts\V1;

use App\DTO\AttendRequestDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreRequestDTO;
use App\Models\Request;
use Illuminate\Pagination\LengthAwarePaginator;

interface RequestRepositoryInterface
{
    public function index(string $userId, PaginatorDTO $paginator): LengthAwarePaginator;
    public function store(StoreRequestDTO $dto): Request;
    public function getByIdOrFail(string $requestId): Request;
    public function attend(string $requestId, AttendRequestDTO $dto): Request;
}