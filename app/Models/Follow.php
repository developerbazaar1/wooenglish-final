<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Follow extends Model
{
    protected $table='follow';
    protected $primaryKey='id';
    protected $fillable=['author_id', 'user_id'];

    public function user(){
        return $this->belongsTo(User::class,'user_id');
    }
}
