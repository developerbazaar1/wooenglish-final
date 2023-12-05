<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InfoPage extends Model
{
    protected $table='info_pages';
    protected $primaryKey='id';
    protected $fillable=['page_name', 'page_description', 'image'];
}
