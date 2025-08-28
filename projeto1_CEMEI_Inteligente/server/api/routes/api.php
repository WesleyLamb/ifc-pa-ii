<?php

use App\Http\Controllers\V1\AuthController;
use App\Http\Controllers\V1\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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
        Route::post('token', [AuthController::class, 'token'])->name('token');
        Route::post('refresh-token', [AuthController::class, 'refreshToken'])->name('refresh-token');
        Route::post('register', [AuthController::class, 'register'])->name('register');
        Route::post('forgot-password', [AuthController::class, 'forgotPassword'])->name('forgot-password');
    });
});