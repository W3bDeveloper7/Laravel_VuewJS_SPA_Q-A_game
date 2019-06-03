<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Game extends Model
{
    protected $guarded = [];
    protected $with = ['questions'];

    public function questions()
    {
        return $this->hasManyThrough(
            Question::class,
            GameItem::class,
            'game_id',
            'id',
            'id',
            'question_id'
        );
    }
}
