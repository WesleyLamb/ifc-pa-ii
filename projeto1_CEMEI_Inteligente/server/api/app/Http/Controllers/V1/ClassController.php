<?php

namespace App\Http\Controllers\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\V1\StoreClassRequest;
use App\Http\Requests\V1\UpdateClassRequest;
use App\Http\Resources\V1\ClassResource;
use App\Services\Contracts\V1\ClassServiceInterface;
use App\Services\V1\ClassService;
use Illuminate\Http\Request;

class ClassController extends Controller
{
    protected ClassService $classService;

    public function __construct(ClassServiceInterface $classService)
    {
        $this->classService = $classService;
    }

    public function index(Request $request)
    {
        return $this->classService->index($request);
    }

    public function store(StoreClassRequest $request)
    {
        return $this->classService->store($request);
    }

    public function show(Request $request)
    {
        return $this->classService->show($request);
    }

    public function update(UpdateClassRequest $request)
    {
        return $this->classService->update($request);
    }

    public function delete(Request $request)
    {
        return $this->classService->delete($request);
    }
}
