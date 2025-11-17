<?php

use App\Http\Controllers\NotificationController;
use App\Http\Controllers\RequestController;
use App\Http\Controllers\V1\FunctionController;
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
        Route::post('forgot-password', [AuthController::class, 'forgotPassword'])->name('.forgot-password');
        Route::post('reset-password', [AuthController::class, 'resetPassword'])->name('.reset-password');
    });

    Route::group(['middleware' => 'auth:api'], function() {
        Route::group(['prefix' => 'users', 'name' => '.users'], function () {
            Route::get('', [UserController::class, 'index'])->name('.index')->middleware('can:users.index');
            Route::group(['prefix' => '{user_id}'], function() {
                Route::get('', [UserController::class, 'show'])->name('.show');
                Route::put('', [UserController::class, 'update']);
            });
        });

        Route::group(['prefix' => 'kids', 'name' => '.kids'], function() {
            Route::get('', [KidController::class, 'index'])->name('.index')->middleware('can:kids.index');
            Route::post('', [KidController::class, 'store'])->name('.store')->middleware('can:kids.create');

            Route::group(['prefix' => '{kid_id}'], function() {
                Route::get('', [KidController::class, 'show'])->name('.show')->middleware('can:kids.detail');
                Route::put('', [KidController::class, 'update'])->name('.update')->middleware('can:kids.change');
                Route::delete('', [KidController::class, 'delete'])->name('.delete')->middleware('can:kids.delete');
            });
        });

        Route::group(['prefix' => 'functions', 'name' => '.functions'], function() {
            Route::get('', [FunctionController::class, 'index'])->name('.index')->middleware('can:functions.index');
            Route::post('', [FunctionController::class, 'store'])->name('.store')->middleware('can:functions.create');
            Route::group(['prefix' => '{function_id}'], function() {
                Route::get('', [FunctionController::class, 'show'])->name('.show')->middleware('can:functions.detail');
                Route::put('', [FunctionController::class, 'update'])->name('.update')->middleware('can:functions.change');
                Route::delete('', [FunctionController::class, 'delete'])->name('.delete')->middleware('can:functions.delete');
            });
        });

        Route::group(['prefix' => 'classes', 'name' => '.classes'], function() {
            Route::get('', [ClassController::class, 'index'])->name('.index')->middleware('can:classes.index');
            Route::post('', [ClassController::class, 'store'])->name('.store')->middleware('can:classes.create');

            Route::group(['prefix' => '{class_id}'], function() {
                Route::get('', [ClassController::class, 'show'])->name('.show')->middleware('can:classes.detail');
                Route::put('', [ClassController::class, 'update'])->name('.update')->middleware('can:classes.change');
                Route::delete('', [ClassController::class, 'delete'])->name('.delete')->middleware('can:classes.delete');

                Route::group(['prefix' => 'kids', 'name' => '.kids'], function() {
                    Route::get('', [ClassController::class, 'indexKids'])->name('.index')->middleware('can:kids.index');
                    Route::post('', [ClassController::class, 'addKid'])->name('.store')->middleware('can:kids.change');

                    Route::group(['prefix' => '{kid_id}'], function() {
                        Route::delete('', [ClassController::class, 'deleteKid'])->name('.delete')->middleware('can:kids.change');
                    });
                });

                Route::group(['prefix' => 'users', 'name' => '.users'], function() {
                    Route::get('', [ClassController::class, 'indexUsers'])->name('.index')->middleware('can:users.index');
                    Route::post('', [ClassController::class, 'storeUser'])->name('.store')->middleware('can:user.change');
                    Route::group(['prefix' => '{user_id}'], function() {
                        Route::delete('', [ClassController::class, 'deleteUser'])->name('.delete')->middleware('can:users.change');
                    });
                });
            });
        });

        Route::group(['prefix' => 'requests'], function() {
            Route::get('', [RequestController::class, 'index']);
            Route::post('', [RequestController::class, 'store']);
            Route::group(['prefix' => '{request_id}'], function() {
                Route::put('attend', [RequestController::class, 'attend']);
            });
        });

        Route::group(['prefix' => 'notifications', 'name' => '.poll'], function() {
            Route::get('poll', [NotificationController::class, 'poll']);
            Route::post('ack', [NotificationController::class, 'ack']);
        });
    });
});