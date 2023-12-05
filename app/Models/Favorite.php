<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Favorite extends Model
{
    protected $table='favorite';
    protected $primaryKey='id';
    protected $fillable=['book_id', 'user_id'];

    public function userdetails(){
        return $this->belongsTo(User::class,'user_id');
    }

    public function bookdetails(){
        return $this->belongsTo(Book::class,'book_id');
    }
}
