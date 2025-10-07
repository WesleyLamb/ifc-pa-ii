<?php

namespace App\Http\Controllers\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\V1\ForgotPasswordRequest;
use App\Http\Requests\V1\ResetPasswordRequest;
use App\Http\Requests\V1\StoreUserRequest;
use App\Http\Requests\V1\TokenRequest;
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

    public function register(StoreUserRequest $request)
    {
        return $this->authService->register($request);
    }

    public function forgotPassword(ForgotPasswordRequest $request)
    {
        return $this->authService->forgotPassword($request);
    }

    public function resetPassword(ResetPasswordRequest $request)
    {
        return $this->authService->resetPassword($request);
    }
}
