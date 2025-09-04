<?php

namespace App\Repositories\Contracts\V1;

use App\DTO\StoreKidDTO;
use App\DTO\UpdateKidDTO;
use App\Models\Kid;
use Illuminate\Database\Eloquent\Collection;

interface KidRepositoryInterface
{
    public function getAll(): Collection;
    public function createKid(StoreKidDTO $dto): Kid;
    public function getKidByIdOrFail(string $kidId): Kid;
    public function updateKid(string $kidId, UpdateKidDTO $dto): Kid;
    public function deleteKid(string $kidId): void;
}