<?php 

namespace App\DTO;

use App\Models\User;
use Carbon\Carbon;
use DateTimeImmutable;
use Illuminate\Http\Request;

class AttendRequestDTO
{
    public User $attendantUser;
    public Carbon $attendantDate;

    public static function fromRequest(Request $request): self
    {
        $dto = new self();

        $dto->attendantUser = $request->user();
        $dto->attendantDate = Carbon::now();

        return $dto;
    }
}