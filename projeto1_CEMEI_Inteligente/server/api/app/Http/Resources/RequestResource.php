<?php

namespace App\Http\Resources;

use App\Http\Resources\V1\ClassSummaryResource;
use App\Http\Resources\V1\KidSummaryResource;
use App\Http\Resources\V1\UserSummaryResource;
use Illuminate\Http\Resources\Json\JsonResource;

class RequestResource extends JsonResource
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
            'type' => $this->type,
            'petitioner' => new UserSummaryResource($this->petitioner),
            'kid' => new KidSummaryResource($this->kid),
            'class' => new ClassSummaryResource($this->class),
            'attendant' => new UserSummaryResource($this->attendant),
            'attended_at' => $this->attendant_date,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at
        ];
    }
}
