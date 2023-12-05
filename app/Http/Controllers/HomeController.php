<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Category;
use App\Models\Book;
use App\Models\Support;
use App\Models\Feedback;
use Auth;
use Illuminate\Support\Facades\Hash;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        $users = User::where('user_role', 'user' )->orderBy('id','DESC')->get();
        $activeusers = User::where('user_role', 'user' )->where('status', 'active' )->orderBy('id','DESC')->get();
        $categories = Category::orderBy('id','DESC')->get();
        $books = Book::orderBy('id','DESC')->get();
        $no_of_activeusers = count($activeusers);
        $no_of_users = count($users);
        $no_of_categories = count($categories);
        $no_of_books = count($books);
        return view('home', compact('no_of_users', 'no_of_categories', 'no_of_books', 'no_of_activeusers'));
    }

    public function setting()
    {
        return view('admin.setting.index');
    }

    public function storesetting(Request $request)
    {
         $validated = $request->validate([
            'password' => 'required|confirmed',
        ]);

        $data = array(
            "password"=>Hash::make($request->input('password')),
        );
        
        User::where('id',Auth::user()->id)->update($data);
        return redirect()->back()->with('success', 'Password updated Successfully');
    }
    
    public function get_feedback()
    {
        $feedbacks = Feedback::orderBy('id','DESC')->get();
        return view('admin.feedback.index',compact('feedbacks'));
    }
    
    public function destroy_feedback($id)
    {
        $delete = Feedback::findOrFail($id);
		if($delete->delete()){
			return redirect('get-feedback')->with('success_add','Feedback Deleted Successfully');
        }
        return redirect('get-feedback')->with('success_add','Feedback Deleted Successfully');
    
    }
    
    public function get_support()
    {
        $supports = Support::orderBy('id','DESC')->get();
        return view('admin.support.index',compact('supports'));
    }
    
     public function destroy_support($id)
    {
        $delete = Support::findOrFail($id);
		if($delete->delete()){
			return redirect('get-support')->with('success_add','Support Deleted Successfully');
        }
        return redirect('get-support')->with('success_add','Support Deleted Successfully');
    
    }

    
}
