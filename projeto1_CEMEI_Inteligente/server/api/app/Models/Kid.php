<?php

namespace App\Models;

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
}
