<?php

namespace App\Http\Requests\V1;

use App\Models\User;
use App\Types\KidTurn;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;

class StoreKidRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        return [
            'library_identifier' => ['required', 'string', Rule::unique('kids', 'library_identifier')],
            'name' => ['required', 'string'],
            'birthday' => ['required', 'date'],
            'father_name' => ['present', 'nullable'],
            'mother_name' => ['present', 'nullable'],
            'cpf' => ['required', Rule::unique('kids', 'cpf')],
            'turn' => ['required', Rule::in('Matutino', 'Vespertino', 'Integral')],
        ];
    }
}
