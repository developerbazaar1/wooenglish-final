<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class QuizUserAnswer extends Model
{
    protected $table='quiz_useranswer';
    protected $primaryKey='id';
    protected $fillable=['question', 'answer', 'quiz_res_id'];
}
