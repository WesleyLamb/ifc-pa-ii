<?php

namespace App\Http\Resources\V1;

use Illuminate\Http\Resources\Json\JsonResource;

class KidResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
            'id' => $this->uuid,
            'library_identifier' => $this->library_identifier,
            'name' => $this->name,
            'birthday' => $this->birthday,
            'father_name' => $this->father_name,
            'mother_name' => $this->mother_name,
            'cpf' => $this->cpf,
            'turn' => ucfirst($this->turnString),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'active' => $this->deleted_at ? false : true,
        ];
    }
}
