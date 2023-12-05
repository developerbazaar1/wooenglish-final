<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserOtp extends Model
{
    protected $table='user_otps';
    protected $primaryKey='id';
    protected $fillable=['user_id', 'otp', 'expire_at'];
}
