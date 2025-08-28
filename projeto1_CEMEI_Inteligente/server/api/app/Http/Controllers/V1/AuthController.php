<?php

namespace App\Http\Controllers\V1;

use App\Http\Controllers\Controller;
use App\Services\V1\AuthService;
use App\Services\Contracts\V1\AuthServiceInterface;
use Illuminate\Http\Request;
use Nette\NotImplementedException;

class AuthController extends Controller
{
    public AuthService $authService;

    public function __construct(AuthServiceInterface $authService)
    {
        $this->authService = $authService;
    }

    public function token(Request $request)
    {
        return $this->authService->token($request);
    }

    public function refreshToken(Request $request)
    {
        return new NotImplementedException();
    }

    public function register(Request $request)
    {
        return new NotImplementedException();
    }

    public function forgotPassword(Request $request)
    {
        return new NotImplementedException();
    }
}
