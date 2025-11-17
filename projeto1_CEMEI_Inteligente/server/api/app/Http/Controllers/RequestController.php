<?php

namespace App\Http\Controllers;

use App\Http\Requests\V1\StoreRequestRequest;
use App\Services\Contracts\V1\RequestServiceInterface;
use App\Services\V1\RequestService;
use Illuminate\Http\Request;

class RequestController extends Controller
{
    protected RequestService $requestService;

    public function __construct(RequestServiceInterface $requestService)
    {
        $this->requestService = $requestService;
    }

    public function index(Request $request)
    {
        return $this->requestService->index($request);
    }

    public function store(StoreRequestRequest $request)
    {
        return $this->requestService->store($request);
    }

    public function attend(Request $request)
    {
        return $this->requestService->attend($request);
    }
}
