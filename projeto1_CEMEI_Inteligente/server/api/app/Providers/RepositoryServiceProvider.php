<?php

namespace App\Providers;

use App\Repositories\Contracts\V1\ClassRepositoryInterface;
use App\Repositories\Contracts\V1\FunctionRepositoryInterface;
use App\Repositories\Contracts\V1\KidRepositoryInterface;
use App\Repositories\Contracts\V1\UserRepositoryInterface;
use App\Repositories\V1\ClassRepository;
use App\Repositories\V1\FunctionRepository;
use App\Repositories\V1\KidRepository;
use App\Repositories\V1\UserRepository;
use Illuminate\Support\ServiceProvider;

class RepositoryServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(
            UserRepositoryInterface::class,
            UserRepository::class
        );

        $this->app->bind(
            KidRepositoryInterface::class,
            KidRepository::class,
        );

        $this->app->bind(
            ClassRepositoryInterface::class,
            ClassRepository::class
        );

        $this->app->bind(
            FunctionRepositoryInterface::class,
            FunctionRepository::class,
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
