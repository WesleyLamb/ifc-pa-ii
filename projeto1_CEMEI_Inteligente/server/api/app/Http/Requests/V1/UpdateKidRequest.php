<?php

namespace App\Http\Requests\V1;

use App\Repositories\Contracts\V1\KidRepositoryInterface;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\App;
use Illuminate\Validation\Rule;

class UpdateKidRequest extends FormRequest
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
        $kid = App::make(KidRepositoryInterface::class)->getKidByIdOrFail(request()->route('kid_id'));
        return [
            'library_identifier' => ['sometimes', 'string', Rule::unique('kids', 'library_identifier')->ignore($kid->uuid, 'uuid')],
            'name' => ['sometimes', 'string'],
            'birthday' => ['sometimes', 'date'],
            'father_name' => ['sometimes', 'nullable'],
            'mother_name' => ['sometimes', 'nullable'],
            'cpf' => ['sometimes', Rule::unique('kids', 'cpf')->ignore($kid->uuid, 'uuid')],
            'turn' => ['sometimes', Rule::in('Matutino', 'Vespertino', 'Integral')],
            'class_id' => ['sometimes', 'exists:classes,id']
        ];
    }
}
