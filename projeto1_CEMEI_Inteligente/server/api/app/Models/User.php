<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;

use Illuminate\Auth\Passwords\CanResetPassword;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Passport\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable, CanResetPassword;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function permissions()
    {
        return $this->hasMany(UserPermission::class, 'user_id', 'id');
    }

    public function can($abilities, $arguments = [])
    {
        $grantedPermissions = [];
        $abilitiesArr = explode('.', $abilities);
        for ($i = 0; $i < substr_count($abilities, '.') + 1; $i++) {
            $grantedPermissions[$i] = null;
            for ($j = 0; $j < $i; $j++) {
                $grantedPermissions[$i] .= $abilitiesArr[$j] . '.';
            }
            $grantedPermissions[$i] .= '*';
        }
        $grantedPermissions[] = $abilities;

        $permission = $this->permissions()->whereIn('permission', $grantedPermissions)->first();
        return $permission == true;
    }
}
