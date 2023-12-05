<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Announcement;
use Illuminate\Support\Facades\Crypt;

class AnnouncementController extends Controller
{
   
    public function index()
    {
        $announcements = Announcement::orderBy('id','DESC')->get();
        return view('admin.announcement.index',compact('announcements'));
    }

    
    public function create()
    {
        return view('admin.announcement.create');
    }

    
    public function store(Request $request)
    { 
        $validated = $request->validate([
            'announcement_name' => 'required',
            'content' => 'required',
        ]);

        $data = array(
            "announcement_name"=>$request->input('announcement_name'),
            "announcement_description"=>$request->input('content'),
        );
        
        $id = Announcement::create($data)->id;
        return redirect()->back()->with('success_add', 'Announcement Added Successfully');
    
    }

   
    public function edit($id)
    {
        $announcementid = Crypt::decrypt($id); 
        $announcement = Announcement::where('id',$announcementid)->first();
        if(!empty($announcement)){
            return view('admin.announcement.edit',compact('announcement'));
        }else{
            return redirect()->back()->with('error','Announcement having error, try again');
        }
    }

    
    public function update(Request $request)
    { 
        
        $id = $request->announcementid;
       
        $data = array(
            "announcement_name"=>$request->announcement_name, 
            "announcement_description"=>$request->content, 
        );
                    
        Announcement::where('id',$id)->update($data);

        return redirect()->back()->with('success', 'Announcement Updated Successfully');
    }


    public function destroy($id)
    {
        $delete = Announcement::findOrFail($id);
		$image = $delete->announcement_image;
		if($delete->delete()){
			if(!empty($image)){
				if(file_exists($image)){
					unlink($image);
				}
			}
        }
        return redirect()->back()->with('success','Announcement Deleted Successfully');
    
    }


   



}

