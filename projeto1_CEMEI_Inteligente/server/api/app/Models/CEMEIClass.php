<?php

namespace App\Models;

use App\DTO\FilterDTO;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CEMEIClass extends Model
{
    use HasUuids, SoftDeletes;

    public $table = 'classes';
    public $primaryKey = 'uuid';
    public $keyType = 'string';
    public $incrementing = false;

    protected $fillable = ['name', 'uuid'];

    public function kids()
    {
        return $this->belongsToMany(
            Kid::class,
            'class_kids',
            'class_id',
            'kid_id'
        );
    }

    public function users()
    {
        return $this->belongsToMany(
            User::class,
            'class_users',
            'class_id',
            'user_id',
            'id',
            'id'
        );
    }

    protected function scopeFilter(Builder $q, FilterDTO $filter)
    {
        return $q;
    }
}
