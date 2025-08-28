<?php

namespace App\Services\V1;

use App\Exceptions\AuthException;
use App\Http\Resources\V1\UserResource;
use App\Services\Contracts\V1\AuthServiceInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Laravel\Passport\Bridge\UserRepository;
use Laravel\Passport\Client;
use League\OAuth2\Server\Repositories\UserRepositoryInterface;
use Nette\NotImplementedException;

class AuthService implements AuthServiceInterface
{
    public UserRepository $userRepository;

    public function __construct(UserRepositoryInterface $userRepository)
    {
        $this->userRepository = $userRepository;
    }

    public function token(Request $request): JsonResponse
    {
        // $client = Client::where('password_client', 1)->first();
        $http = Http::asForm()->post('http://nginx/oauth/token', [
            'grant_type' => 'password',
            'client_id' => $request->get('client_id'),
            'client_secret' => $request->get('client_secret'),
            'username' => $request->get('username') ?? $request->get('email'),
            'password' => $request->get('password'),
            'scope' => '*',
        ]);

        if ($http->status() != 200) {
            Log::error('Error trying to authenticate ' . $request->get('username') . ': ' . json_encode($http->json()));
            throw new AuthException($http->json()['message'], 101);
        }
        return response()->json($http->json());
    }

    public function refreshToken(Request $request): JsonResponse
    {
        throw new NotImplementedException();
    }

    public function register(Request $request): UserResource
    {
        throw new NotImplementedException();
    }

    public function forgotPassword(Request $request): JsonResponse
    {
        throw new NotImplementedException();
    }
}