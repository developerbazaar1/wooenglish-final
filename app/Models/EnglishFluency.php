<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EnglishFluency extends Model
{
    protected $table='english_fluency';
    protected $primaryKey='id';
    protected $fillable=['name'];
}
