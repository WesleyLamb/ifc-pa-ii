<?php

namespace App\Http\Middleware;

use App\Models\User;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserCan
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next, ...$abilities)
    {
        /** @var User $user */
        $user = Auth::user();
        $allowed = false;
        foreach ($abilities as $ability) {
            if ($user->can($ability))
                $allowed = true;
        }
        if (!$allowed)
            abort(403);
        return $next($request);
    }
}
