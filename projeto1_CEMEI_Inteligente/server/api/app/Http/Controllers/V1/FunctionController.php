<?php

namespace App\Http\Controllers\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\V1\StoreFunctionRequest;
use App\Services\Contracts\V1\FunctionServiceInterface;
use App\Services\V1\FunctionService;
use Illuminate\Http\Request;

class FunctionController extends Controller
{
    protected FunctionService $functionService;

    public function __construct(FunctionServiceInterface $functionService)
    {
        $this->functionService = $functionService;
    }

    public function index(Request $request)
    {
        return $this->functionService->index($request);
    }

    public function store(StoreFunctionRequest $request)
    {
        return $this->functionService->store($request);
    }
}
