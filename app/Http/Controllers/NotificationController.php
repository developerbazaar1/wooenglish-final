<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Notification;
use Illuminate\Support\Facades\Crypt;

class NotificationController extends Controller
{
   
    public function index()
    {
        $notifications = Notification::orderBy('id','DESC')->get();
        return view('admin.notification.index',compact('notifications'));
    }

    
    public function create()
    {
        return view('admin.notification.create');
    }

    
    public function store(Request $request)
    { 
        $validated = $request->validate([
            'notification_name' => 'required',
            'content' => 'required',
        ]);

        $data = array(
            "notification_name"=>$request->input('notification_name'),
            "notification_description"=>$request->input('content'),
        );
        
        $id = Notification::create($data)->id;
        return redirect()->back()->with('success_add', 'Notification Added Successfully');
    
    }

   
    public function edit($id)
    {
        $notificationid = Crypt::decrypt($id); 
        $notification = Notification::where('id',$notificationid)->first();
        if(!empty($notification)){
            return view('admin.notification.edit',compact('notification'));
        }else{
            return redirect()->back()->with('error','Notification having error, try again');
        }
    }

    
    public function update(Request $request)
    { 
        
        $id = $request->notificationid;
       
        $data = array(
            "notification_name"=>$request->notification_name, 
            "notification_description"=>$request->content, 
        );
                    
        Notification::where('id',$id)->update($data);

        return redirect()->back()->with('success', 'Notification Updated Successfully');
    }


    public function destroy($id)
    {
        $delete = Notification::findOrFail($id);
		$image = $delete->notification_image;
		if($delete->delete()){
			if(!empty($image)){
				if(file_exists($image)){
					unlink($image);
				}
			}
        }
        return redirect()->back()->with('success','Notification Deleted Successfully');
    
    }


   



}

