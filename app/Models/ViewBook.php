<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ViewBook extends Model
{
    protected $table='view_books';
    protected $primaryKey='id';
    protected $fillable=['book_id', 'user_id', 'chapter', 'video', 'status', 'read_type', 'percentage'];
    
    public function bookdetails(){
        return $this->belongsTo(Book::class,'book_id');
    }
}
