<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Subscription extends Model
{
    protected $table='subscription';
    protected $primaryKey='id';
    protected $fillable=['plan_name', 'plan_duration', 'plan_period', 'plan_price', 'status'];
}
