<?php

namespace App\Http\Resources\V1;

use Illuminate\Http\Resources\Json\JsonResource;

class KidSummaryResource extends JsonResource
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
            'cpf' => $this->cpf,
            'turn' => ucfirst($this->turnString),
            'class' => new ClassSummaryResource($this->class),
            'active' => $this->deleted_at ? false : true,
        ];
    }
}
