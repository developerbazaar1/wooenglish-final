<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TranscationHistory extends Model
{
    protected $table='transcation_history';
    protected $primaryKey='id';
    protected $fillable=['plan_id', 'user_id', 'amount', 'currency', 'status', 'transaction_id'];
}
