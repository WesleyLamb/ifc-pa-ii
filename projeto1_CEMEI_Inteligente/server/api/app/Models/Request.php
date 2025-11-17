<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Request extends Model
{
    use HasFactory;

    public function petitioner()
    {
        return $this->hasOne(User::class, 'id', 'petitioner_user_id');
    }

    public function attendant()
    {
        return $this->hasOne(User::class, 'id', 'attendant_user_id');
    }

    public function requestUsers()
    {
        return $this->hasMany(RequestUser::class, 'request_id', 'id');
    }

    public function users()
    {
        return $this->hasManyThrough(User::class, RequestUser::class, 'request_id', 'id', 'id', 'user_id');
    }

    public function kid()
    {
        return $this->hasOne(Kid::class, 'id', 'kid_id');
    }

    public function class()
    {
        return $this->hasOne(CEMEIClass::class, 'id', 'class_id');
    }

    public function scopeFromUser(Builder $q, $userId)
    {
        return $q = $q->whereHas('users', function($q) use ($userId) {
            return $q->where('uuid', $userId);
        });
    }

    public function scopePending(Builder $q)
    {
        return $q = $q->whereNull('attendant_user_id');
    }
}
