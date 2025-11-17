<?php

namespace App\Http\Controllers;

use App\Services\Contracts\V1\NotificationServiceInterface;
use Illuminate\Http\Request;

class NotificationController extends Controller
{
    protected NotificationService $notificationService;

    public function __construct(NotificationServiceInterface $notificationService)
    {
        $this->notificationService = $notificationService;
    }

    public function poll(Request $request) {

        return $this->notificationService->poll($request);
    }
}
