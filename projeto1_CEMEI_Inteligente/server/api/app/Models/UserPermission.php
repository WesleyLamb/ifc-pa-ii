<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class UserPermission extends Model
{
    use HasUuids;

    public $table = 'user_permissions';
    public $primaryKey = 'uuid';
}
