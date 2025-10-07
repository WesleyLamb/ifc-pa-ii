<?php

namespace App\DTO;

use Illuminate\Http\Request;

class PaginatorDTO
{
    public int $perPage;
    public int $page;

    public static function fromRequest(Request $request): self
    {
        $dto = new self();
        $dto->perPage = $request->query('per_page', 10);
        $dto->page = $request->query('page', 1);

        return $dto;
    }
}