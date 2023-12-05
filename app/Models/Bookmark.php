<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Bookmark extends Model
{
    protected $table='bookmark';
    protected $primaryKey='id';
    protected $fillable=['book_id', 'user_id', 'chapter_id', 'chapter_name'];

    public function userdetails(){
        return $this->belongsTo(User::class,'user_id');
    }

    public function bookdetails(){
        return $this->belongsTo(Book::class,'book_id');
    }
}
