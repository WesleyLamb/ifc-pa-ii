<?php

namespace App\DTO;

use App\Http\Requests\V1\AddUserToClassRequest;
use App\Models\CEMEIFunction;
use App\Models\User;

class AddUserToClassDTO
{
    public User $user;
    public CEMEIFunction $function;

    public function __construct(User $user, CEMEIFunction $function)
    {
        $this->user = $user;
        $this->function = $function;
    }
}