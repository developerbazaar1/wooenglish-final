<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HomeCategory extends Model
{
    protected $table='home_category';
    protected $primaryKey='id';
    protected $fillable=['name'];
}
