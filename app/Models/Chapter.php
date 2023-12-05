<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Chapter extends Model
{
    protected $table='chapters';
    protected $primaryKey='id';
    protected $fillable=['chapter_no', 'chapter_name', 'chapter_description', 'book_id', 'audio', 'audio_title'];


    public function bookdetails(){
        return $this->belongsTo(Book::class,'book_id');
    }
}
