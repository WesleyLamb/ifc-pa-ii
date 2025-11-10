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

    protected $fillable = ['name', 'library_identifier', 'birthday', 'turn', 'father_name', 'mother_name', 'cpf'];

    public function uniqueIds(): array
    {
        return ['uuid'];
    }

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
        return $this->belongsToMany(
            CEMEIClass::class,
            'class_kids',
            'kid_id',
            'class_id',
            'id',
            'id'
        );
    }

    protected function scopeFilter(Builder $q, FilterDTO $filter)
    {
        return $q;
    }
}
