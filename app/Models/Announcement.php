<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Announcement extends Model
{
    protected $table='announcement';
    protected $primaryKey='id';
    protected $fillable=['announcement_name', 'announcement_description'];
}
