<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class  Length  extends Model
{
    protected $table='length';
    protected $primaryKey='id';
    protected $fillable=['name'];
}
