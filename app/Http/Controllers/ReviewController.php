<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Review;
use Illuminate\Support\Facades\Crypt;

class ReviewController extends Controller
{
   
    public function index($bookid)
    {
        $id = Crypt::decrypt($bookid);
        $reviews = Review::where('book_id', $id)->orderBy('id','DESC')->get();
        return view('admin.review.index',compact('reviews'));
    }

    

    
    public function destroy($id)
    {
        $delete = Review::findOrFail($id);
		$image = $delete->review_image;
		if($delete->delete()){
			if(!empty($image)){
				if(file_exists($image)){
					unlink($image);
				}
			}
        }
        return redirect()->back()->with('success','Review Deleted Successfully');
    
    }


     public function update(Request $request)
    { 
       
        $id = $request->review_id;
        $review = Review::find($id);
        
        $data = array(
            "reply"=>$request->content, 
        );
                    
        Review::where('id',$id)->update($data);

        return response()->json(['success'=>'Review added successfully.']);
    }




}

