<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class  Review  extends Model
{
    protected $table='reviews';
    protected $primaryKey='id';
    protected $fillable=['name', 'review', 'rating', 'book_id', 'user_id', 'reply'];

    public function userdetails(){
        return $this->belongsTo(User::class,'user_id', 'user_id');
    }
    
    public function bookdetails(){
        return $this->belongsTo(Book::class,'book_id');
    }
}
