<?php

namespace App\Repositories\V1;

use App\DTO\AttendRequestDTO;
use App\DTO\PaginatorDTO;
use App\DTO\StoreRequestDTO;
use App\Models\CEMEIFunction;
use App\Models\Request;
use App\Models\RequestUser;
use App\Models\User;
use App\Notifications\DispatchKid;
use App\Notifications\EscortKid;
use App\Repositories\Contracts\V1\RequestRepositoryInterface;
use App\Services\V1\UserService;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Notification;

class RequestRepository implements RequestRepositoryInterface
{
    public function index(string $userId, PaginatorDTO $paginator): LengthAwarePaginator
    {
        return Request::fromUser($userId)->pending()->paginate($paginator->perPage);
    }

    public function store(StoreRequestDTO $dto): Request
    {
        $request = new Request();

        $request->petitioner_user_id = $dto->petitionerUser->id;
        $request->type = $dto->type;
        $request->kid_id = $dto->kid->id;
        $request->class_id = $dto->class->id;
        $request->save();
        $request->refresh();

        $addedUsers = collect();

        foreach ($dto->class->users as $user) {
            if (!$addedUsers->contains($user)) {

                $requestUser = new RequestUser();
                $requestUser->request_id = $request->id;
                $requestUser->user_id = $user->id;

                $requestUser->save();

                $addedUsers->add($user);
            }
        }

        $notifiableUsers = User::whereHas('functions', function($q) use ($dto) {
            if ($dto->type == 'dispatch') {
                return $q->where('notify_dispatch', true);
            } else {
                return $q->where('notify_escort', true);
            }
        })->get();

        foreach ($notifiableUsers as $user) {
            if (!$addedUsers->contains($user)) {

                $requestUser = new RequestUser();
                $requestUser->request_id = $request->id;
                $requestUser->user_id = $user->id;

                $requestUser->save();

                $addedUsers->add($user);
            }
        }

        $request = $request->refresh();
        if ($dto->type == 'dispatch') {
            Notification::send($addedUsers, new DispatchKid($request));
        } else {
            Notification::send($addedUsers, new EscortKid($request));
        }

        return $request;
    }

    public function getByIdOrFail(string $requestId): Request
    {
        return Request::where('uuid', $requestId)->firstOrFail();
    }

    public function attend(string $requestId, AttendRequestDTO $dto): Request
    {
        $request = $this->getByIdOrFail($requestId);

        $request->attendant_user_id = $dto->attendantUser->id;
        $request->attendant_date = $dto->attendantDate;
        $request->save();

        return $request->refresh();
    }
}