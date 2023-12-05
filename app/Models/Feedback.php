<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Feedback extends Model
{
    protected $table='feedback';
    protected $primaryKey='id';
    protected $fillable=['user_id', 'msg', 'name', 'email'];
}
