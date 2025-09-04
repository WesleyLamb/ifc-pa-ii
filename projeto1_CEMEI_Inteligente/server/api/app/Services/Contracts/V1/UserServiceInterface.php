<?php

namespace App\Services\Contracts\V1;

use Illuminate\Http\Request;

interface UserServiceInterface
{
    public function show(Request $request);
}