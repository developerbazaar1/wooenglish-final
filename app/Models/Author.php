<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Author extends Model
{
    protected $table='author';
    protected $primaryKey='id';
    protected $fillable=['name', 'status', 'author_image'];
}
