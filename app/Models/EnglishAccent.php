<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EnglishAccent extends Model
{
    protected $table='english_accent';
    protected $primaryKey='id';
    protected $fillable=['name'];
}
