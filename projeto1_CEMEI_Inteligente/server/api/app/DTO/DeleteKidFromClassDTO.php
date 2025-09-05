<?php

namespace App\DTO;

use App\Models\Kid;

class DeleteKidFromClassDTO
{
    public Kid $kid;

    public function __construct(Kid $kid)
    {
        $this->kid = $kid;
    }
}