<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Quiz;
use App\Models\QuizResponse;  
use App\Models\QuizUserAnswer;
use Illuminate\Support\Facades\Crypt;

class QuizController extends Controller
{
   
    public function index($bookid)
    {
        $id = Crypt::decrypt($bookid); 
        $quizs = Quiz::where('book_id', $id)->orderBy('id','DESC')->get();
        return view('admin.quiz.index',compact('quizs', 'id'));
    }

    
    public function create()
    {
        return view('admin.quiz.create');
    }

    
    public function store(Request $request)
    { 
        $validated = $request->validate([
            'question' => 'required',
        ]);

        $data = array(
            "question"=>$request->input('question'),
            "book_id"=>$request->input('bookid'),
        );
        
        $id = Quiz::create($data)->id;
        return redirect()->back()->with('success_add', 'Quiz Added Successfully');
    
    }

    
   
    
    public function destroy($id)
    {
        $delete = Quiz::findOrFail($id);
		$image = $delete->quiz_image;
		if($delete->delete()){
			if(!empty($image)){
				if(file_exists($image)){
					unlink($image);
				}
			}
        }
        return redirect()->back()->with('success','Quiz Deleted Successfully');
    
    }

    public function quiz_response($bookid)
    {
        $id = Crypt::decrypt($bookid); 
        $quizs = QuizResponse::where('book_id', $id)->orderBy('id','DESC')->get();
        return view('admin.quiz.quizresponse',compact('quizs', 'id'));
    }

    public function destroyquizresponse($id)
    {
        $delete = QuizResponse::findOrFail($id);
        $image = $delete->quiz_image;
        if($delete->delete()){
            if(!empty($image)){
                if(file_exists($image)){
                    unlink($image);
                }
            }
        }
        return redirect()->back()->with('success','Quiz Response Deleted Successfully');
    
    }
   
    public function quiz_useranswer($quizresid)
    {
        $id = Crypt::decrypt($quizresid); 
        $quiz_res = QuizResponse::where('id', $id)->first();
        $quizs = QuizUserAnswer::where('quiz_res_id', $id)->orderBy('id','ASC')->get();
        return view('admin.quiz.quizuseranswer',compact('quizs', 'id', 'quiz_res'));
    }

    public function quiz_useranswer_store(Request $request)
    { 
        
        $id = $request->quizresid;
        
        $data = array(
            "admin_reply"=>$request->admin_reply, 
        );
                    
        QuizResponse::where('id',$id)->update($data);
        return redirect()->back()->with('success','Quiz reply added successfully.');
        
    }

}

