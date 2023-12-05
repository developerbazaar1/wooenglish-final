<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Quiz extends Model
{
    protected $table='quiz';
    protected $primaryKey='id';
    protected $fillable=['question', 'book_id'];
}
