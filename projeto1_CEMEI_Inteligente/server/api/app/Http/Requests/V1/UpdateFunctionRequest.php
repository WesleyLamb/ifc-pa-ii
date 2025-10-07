<?php

namespace App\Http\Requests\V1;

use App\Repositories\Contracts\V1\FunctionRepositoryInterface;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\App;
use Illuminate\Validation\Rule;

class UpdateFunctionRequest extends FormRequest
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
        $function = App::make(FunctionRepositoryInterface::class)->getByIdOrFail(request()->route('function_id'));
        return [
            'name' => ['required', Rule::unique('functions', 'name')->ignore($function->uuid, 'uuid')],
        ];
    }
}
