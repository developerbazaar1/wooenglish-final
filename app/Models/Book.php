<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Book extends Model
{
    protected $table='book';
    protected $primaryKey='id';
    protected $fillable=['title', 'category', 'author_name', 'english_fluency', 'english_accent', 'total_words', 'genre', 'total_time', 'level', 'book_thumbnail', 'status', 'book_description', 'audio', 'audio_title', 'video', 'video_title', 'home_category', 'showbookto', 'views', 'is_audio', 'rating', 'length', 'language'];

    public function favorites()
    {
        return $this->hasMany(Favorite::class);
    }

    public function bookmark()
    {
        return $this->hasMany(Bookmark::class);
    }
    
    public function ratings()
    {
        return $this->hasMany(Review::class);
    }
    
    public function chapters()
    {
        return $this->hasMany(Chapter::class);
    }
    
    public function author(){
        return $this->belongsTo(Author::class,'author_name');
    }
    
}
