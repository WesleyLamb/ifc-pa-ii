<?php

namespace App\Providers;

use App\Services\Contracts\V1\AuthServiceInterface;
use App\Services\Contracts\V1\ClassServiceInterface;
use App\Services\Contracts\V1\FunctionServiceInterface;
use App\Services\Contracts\V1\KidServiceInterface;
use App\Services\Contracts\V1\RequestServiceInterface;
use App\Services\Contracts\V1\UserServiceInterface;
use App\Services\V1\AuthService;
use App\Services\V1\ClassService;
use App\Services\V1\FunctionService;
use App\Services\V1\KidService;
use App\Services\V1\RequestService;
use App\Services\V1\UserService;
use Illuminate\Support\ServiceProvider;

class ServiceServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(
            AuthServiceInterface::class,
            AuthService::class
        );

        $this->app->bind(
            KidServiceInterface::class,
            KidService::class
        );

        $this->app->bind(
            UserServiceInterface::class,
            UserService::class
        );

        $this->app->bind(
            ClassServiceInterface::class,
            ClassService::class
        );

        $this->app->bind(
            FunctionServiceInterface::class,
            FunctionService::class
        );

        $this->app->bind(
            RequestServiceInterface::class,
            RequestService::class
        );
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
