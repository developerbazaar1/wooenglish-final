<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Subscription;

class UserController extends Controller
{
   
    public function index()
    {
        $users = User::where('user_role', 'user')->orderBy('id','DESC')->get();
        $membership_plans = Subscription::orderBy('id','DESC')->get();
        return view('admin.user.index',compact('users', 'membership_plans'));
    }

    
   
    
    public function destroy($id)
    {
        $delete = User::findOrFail($id);
		$image1 = $delete->user_image;
		$image  =  $image1;
		if($delete->delete()){
			if(!empty($image)){
				if(file_exists($image)){
					unlink($image);
				}
			}
        }
        return redirect('users')->with('success_add','User Deleted Successfully');
    
    }


    public function changeUserStatus(Request $request)

    {
        $id = $request->user_id;
        $user = User::find($id);

        if($request->status == '1'){
            $data = array(
                "status"=>'active', 
            );
        }else{
            $data = array(
                "status"=>'inactive', 
            );
        }            
          
        User::where('id',$id)->update($data);

        return response()->json(['success'=>'Status change successfully.']);

    }


    public function update(Request $request)
    { 
      
        $id = $request->user_id;
        $user = User::find($id);
        
        $date = date("Y-m-d");
        $data = array(
            "membership_plan"=>$request->membership_plan, 
            "membership_date"=>$date, 
            "status"=>"active", 
            
        );
                  
        User::where('id',$id)->update($data);

        return response()->json(['success'=>'Membership updated successfully.']);
    }



}

