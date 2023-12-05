<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Planperiod extends Model
{
    protected $table='plan_period';
    protected $primaryKey='id';
    protected $fillable=['name'];
}
