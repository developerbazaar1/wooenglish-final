<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use App\Models\Book;
use App\Models\Author;
use App\Models\Follow;
use App\Models\Review;
use App\Models\HomeCategory;
use App\Models\Chapter;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Models\Quiz;
use App\Models\QuizResponse;
use App\Models\QuizUserAnswer;

class QuizController extends Controller
{
    
    public function get_quiz(Request $request)
    {
        
        if ($request->has('book_id')) {
            $book_id = $request->input('book_id');
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Book id required, please try again',
            ], 401);
        }
        
        $quizs = Quiz::where('book_id', $book_id)->get();
        
        if($quizs){
            return response()->json([
                'status' => true,
                'message' => 'Get quiz successfully',
                'quiz' => $quizs,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'quiz not exist, please try again',
            ], 401);
        }
       
    }

    public function get_quiz_reply(Request $request)
    {
        if ($request->has('limit')) {
            $limit = $request->input('limit');
        }else{
            $limit = 10;
        }
        
        if ($request->has('offset')) {
            $offset = $request->input('offset');
        }else{
            $offset = 0;
        }
            
        if ($request->has('book_id')) {
            $book_id = $request->input('book_id');
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Book id required, please try again',
            ], 401);
        }
        
        $quizs = QuizResponse::with('userdetails')->where('book_id', $book_id)->skip($offset)->take($limit)->orderBy('id','DESC')->get();
        
        if($quizs){
            return response()->json([
                'status' => true,
                'message' => 'Get quiz response successfully',
                'quiz' => $quizs,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'quiz response not exist, please try again',
            ], 401);
        }
       
    }

    public function quiz_user_answer(Request $request)
    {
         
        // $string_version = implode(',', $request->answer);
        $answer = explode(',', $request->answer);
       
        // $string_version1 = implode(',', $request->question);
        $question = explode(',', $request->question);

        try {

            $validateUser = Validator::make($request->all(), 
            [
                'question' => 'required',
                'answer' => 'required',
                'book_id' => 'required',
           
         
            ]);

            if($validateUser->fails()){
                return response()->json([
                    'status' => false,
                    'message' => 'validation error',
                    'errors' => $validateUser->errors()
                ], 401);
            }

                
                $QuizResponsedata = QuizResponse::create([
                    'book_id' => $request->book_id,
                    'user_id' => auth::user()->user_id,
                    'name' => auth::user()->name,
                ]);

                $no_ans = count($answer);

                
                if($QuizResponsedata){
                    for ($i=0; $i < $no_ans; $i++) { 
                        $QuizUserAnswerdata = QuizUserAnswer::create([
                            'question' => $question[$i],
                            'answer' => $answer[$i],
                            'quiz_res_id' => $QuizResponsedata->id,
                        ]);
                    }
                     
                }

               

                return response()->json([
                    'status' => true,
                    'message' => 'quiz answers added successfully',
                    // 'data' => $QuizUserAnswerdata,
                ], 200);
            
        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }

    public function get_user_quiz_old()
    {
       
        $quizs = QuizResponse::with('bookdetails')->where('user_id', Auth::user()->user_id)->get();
        
        $quiz_ques_ans = array();
        foreach($quizs as $q){
            $quiz_ques_ans1 = QuizUserAnswer::where('quiz_res_id', $q->id)->get();
            array_push($quiz_ques_ans, $quiz_ques_ans1);
        }

        if($quizs){
            
          
            return response()->json([
                'status' => true,
                'message' => 'Get quiz response successfully',
                'quiz' => $quizs,
                'quiz_question_answers' => $quiz_ques_ans,
                
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'quiz response not exist, please try again',
            ], 401);
        }
       
    }
    
    public function get_user_quiz(Request $request)
    {
         if ($request->has('limit')) {
            $limit = $request->input('limit');
        }else{
            $limit = 10;
        }
        
        if ($request->has('offset')) {
            $offset = $request->input('offset');
        }else{
            $offset = 0;
        }
            
        $quizs = QuizResponse::with('bookdetails')->with('userdetails')->where('user_id', Auth::user()->user_id)->skip($offset)->take($limit)->get();
        

        if($quizs){
              $ffbooks = Book::with('favorites')->where('status', 'active')->orderBy('id','DESC')->get();

                $a = array();
                foreach ($ffbooks as $pbook) {
              
                    foreach ($pbook->favorites as $fav) {
        
                        if($fav->user_id == auth::user()->user_id){ 
                            array_push($a, $fav->book_id);
                        }
                        
                    }
                }
                
            return response()->json([
                'status' => true,
                'message' => 'Get quiz books successfully',
                'quiz' => $quizs,
                'favorite' => $a,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'quiz response not exist, please try again',
            ], 401);
        }
       
    }
    
    public function get_user_quiz_book_wise(Request $request)
    {
        if ($request->has('quiz_id')) {
            $id = $request->input('quiz_id');
        }else{
            return response()->json([
                'status' => false,
                'message' => 'quiz id is required, please try again',
            ], 400);
        }
        
        if ($request->has('limit')) {
            $limit = $request->input('limit');
        }else{
            $limit = 10;
        }
        
        if ($request->has('offset')) {
            $offset = $request->input('offset');
        }else{
            $offset = 0;
        }
       
        $quiz_ques_ans = QuizUserAnswer::where('quiz_res_id', $id)->skip($offset)->take($limit)->orderBy('id','DESC')->get();
        $quiz_main = QuizResponse::where('id', $id)->first();
        if($quiz_ques_ans){
            return response()->json([
                'status' => true,
                'message' => 'Get bookwise quiz response successfully',
                'quiz' => $quiz_ques_ans,
                'admin_reply' => $quiz_main->admin_reply,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'quiz response not exist, please try again',
            ], 400);
        }
       
    }
    

}
