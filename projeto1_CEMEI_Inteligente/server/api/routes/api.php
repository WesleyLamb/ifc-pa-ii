<?php

use App\Http\Controllers\V1\AuthController;
use App\Http\Controllers\V1\ClassController;
use App\Http\Controllers\V1\KidController;
use App\Http\Controllers\V1\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Psy\Command\ListCommand\ClassConstantEnumerator;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });


Route::group(['prefix' => 'v1', 'name' => 'api.v1'], function() {
    Route::group(['prefix' => 'auth', 'name' => 'auth'], function() {
        Route::post('register', [AuthController::class, 'register'])->name('register');
        Route::post('forgot-password', [AuthController::class, 'forgotPassword'])->name('forgot-password');
    });

    Route::group(['middleware' => 'auth:api'], function() {
        Route::group(['prefix' => 'users', 'name' => '.users'], function () {
            Route::get('{user_id}', [UserController::class, 'show'])->name('.me');
        });

        Route::group(['prefix' => 'kids', 'name' => '.kids'], function() {
            Route::get('', [KidController::class, 'index'])->name('.index')->middleware('can:kids.index');
            Route::post('', [KidController::class, 'store'])->name('.store')->middleware('can:kids.create');

            Route::group(['prefix' => '{kid_id}'], function() {
                Route::get('', [KidController::class, 'show'])->name('.show')->middleware('can:kids.detail');
                Route::put('', [KidController::class, 'update'])->name('.update')->middleware('can:kids.change');
                Route::delete('', [KidController::class, 'delete'])->name('.delete')->middleware('can:kids.delete');
            });

            Route::group(['prefix' => 'classes', 'name' => 'classes'], function() {
                Route::get('', [ClassController::class, 'index']);
                Route::post('', [ClassController::class, 'store']);

                Route::group(['prefix' => '{class_id}'], function() {
                    Route::get('', [ClassController::class, 'show']);
                    Route::put('', [ClassController::class, 'update']);
                    Route::delete('', [ClassController::class, 'delete']);
                });
            });
        });
    });
});