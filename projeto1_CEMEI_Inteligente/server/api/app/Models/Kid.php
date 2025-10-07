<?php

namespace App\Models;

use App\DTO\FilterDTO;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class Kid extends Model
{
    use HasUuids, SoftDeletes;

    public $table = 'kids';
    public $primaryKey = 'uuid';

    protected function getTurnStringAttribute()
    {
        return match($this->turn) {
            '1' => 'matutino',
            '2' => 'vespertino',
            '3' => 'integral'
        };
    }

    protected function setTurnStringAttribute($value)
    {
        $this->turn = match(Str::lower($value)) {
            'matutino' => '1',
            'vespertino' => '2',
            'integral' => '3'
        };
    }

    public function classes()
    {
        return $this->hasManyThrough(CEMEIClass::class, ClassKid::class, 'kid_id', 'id', 'id', 'class_id');
    }

    protected function scopeFilter(Builder $q, FilterDTO $filter)
    {
        return $q;
    }
}
