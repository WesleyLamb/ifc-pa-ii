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

    protected function scopeFilter(Builder $q, FilterDTO $filter)
    {
        return $q;
    }
}
