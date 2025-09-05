<?php

namespace App\DTO;

use App\Models\Kid;

class AddKidToClassDTO
{
    public Kid $kid;

    public function __construct(Kid $kid)
    {
        $this->kid = $kid;
    }
}