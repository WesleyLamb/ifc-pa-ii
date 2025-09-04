<?php

namespace App\Services\V1;

use App\Http\Resources\V1\UserResource;
use App\Repositories\Contracts\V1\UserRepositoryInterface;
use App\Repositories\V1\UserRepository;
use App\Services\Contracts\V1\UserServiceInterface;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserService implements UserServiceInterface
{
    public UserRepository $userRepository;

    public function __construct(UserRepositoryInterface $userRepository)
    {
        $this->userRepository = $userRepository;
    }

    public function show(Request $request)
    {
        $userId = $request->route('user_id');
        if ($userId == 'me') {
            $userId = Auth::user()->uuid;
        }
        return new UserResource($this->userRepository->getByIdOrFail($userId));
    }
}