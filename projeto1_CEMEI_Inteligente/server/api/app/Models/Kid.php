<?php

namespace App\Models;

use App\DTO\FilterDTO;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class Kid extends Model
{
    use HasUuids, SoftDeletes;

    public $table = 'kids';
    public $primaryKey = 'uuid';
    public $keyType = 'string';
    public $incrementing = false;

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

    public function class()
    {
        return $this->belongsTo(CEMEIClass::class, 'class_id', 'id');
    }

    protected function scopeFilter(Builder $q, FilterDTO $filter)
    {
        $filterInt = preg_replace('/[^0-9]+/', '', $filter->q);

        return $q = $q->where(function($q) use ($filter, $filterInt) {
            return $q->where('name', 'ilike', "%$filter->q%")
                    ->orWhere('cpf', 'like', "%$filterInt%")
                    ->orWhere('father_name', 'ilike', "%$filter->q%")
                    ->orWhere('mother_name', 'ilike', "%$filter->q%");
        });
    }
}
