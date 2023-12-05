<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Support extends Model
{
    protected $table='support';
    protected $primaryKey='id';
    protected $fillable=['user_id', 'msg', 'name', 'email'];
}
