<?php

namespace App\Http\Controllers\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\V1\StoreKidRequest;
use App\Http\Requests\V1\UpdateKidRequest;
use App\Services\Contracts\V1\KidServiceInterface;
use App\Services\V1\KidService;
use Illuminate\Http\Request;

class KidController extends Controller
{
    public KidService $kidService;

    public function __construct(KidServiceInterface $kidService)
    {
        $this->kidService = $kidService;
    }

    public function index(Request $request)
    {
        return $this->kidService->index($request);
    }

    public function store(StoreKidRequest $request)
    {
        return $this->kidService->store($request);
    }

    public function show(Request $request)
    {
        return $this->kidService->show($request);
    }

    public function update(UpdateKidRequest $request)
    {
        return $this->kidService->update($request);
    }

    public function delete(Request $request)
    {
        return $this->kidService->delete($request);
    }
}
