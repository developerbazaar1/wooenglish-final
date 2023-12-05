<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class  ThirdPartyData  extends Model
{
    protected $table='thirdparty_data';
    protected $primaryKey='id';
    protected $fillable=['facebook_url', 'youtube_url', 'mob_id', 'paypal_id'];
}
