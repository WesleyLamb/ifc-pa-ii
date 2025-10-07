<?php

namespace App\Http\Controllers\V1;

use App\Http\Controllers\Controller;
use App\Services\Contracts\V1\UserServiceInterface;
use App\Services\V1\UserService;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public UserService $userService;

    public function __construct(UserServiceInterface $userService)
    {
        $this->userService = $userService;
    }

    public function index(Request $request)
    {
        return $this->userService->index($request);
    }

    public function show(Request $request)
    {
        return $this->userService->show($request);
    }
}
