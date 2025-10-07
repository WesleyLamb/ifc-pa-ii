<?php

namespace App\DTO;

use App\Models\User;

class DeleteUserFromClassDTO
{
    public User $user;

    public function __construct(User $user)
    {
        $this->user = $user;
    }
}