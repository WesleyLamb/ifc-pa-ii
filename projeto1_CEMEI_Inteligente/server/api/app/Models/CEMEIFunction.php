<?php

namespace App\Models;

use App\DTO\FilterDTO;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CEMEIFunction extends Model
{
    use SoftDeletes, HasUuids;

    public $table = 'functions';
    public $primaryKey = 'uuid';

    public function scopeFilter(Builder $q, FilterDTO $filter)
    {
        return $q;
    }
}
