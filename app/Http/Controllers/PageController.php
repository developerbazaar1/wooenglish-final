<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Page;
use Illuminate\Support\Facades\Crypt;

class PageController extends Controller
{
   
    public function index()
    {
        $pages = Page::orderBy('id','DESC')->get();
        return view('admin.page.index',compact('pages'));
    }

    
    public function create()
    {
        return view('admin.page.create');
    }

    
    public function store(Request $request)
    { 
        $validated = $request->validate([
            'page_name' => 'required',
            'content' => 'required',
        ]);

        $data = array(
            "page_name"=>$request->input('page_name'),
            "page_description"=>$request->input('content'),
        );
        
        $id = Page::create($data)->id;
        return redirect()->back()->with('success_add', 'Page Added Successfully');
    
    }

   
    public function edit($id)
    {
        $pageid = Crypt::decrypt($id); 
        $page = Page::where('id',$pageid)->first();
        if(!empty($page)){
            return view('admin.page.edit',compact('page'));
        }else{
            return redirect()->back()->with('error','Page having error, try again');
        }
    }

    
    public function update(Request $request)
    { 
        
        $id = $request->pageid;
       
        $data = array(
            "page_name"=>$request->page_name, 
            "page_description"=>$request->content, 
        );
                    
        Page::where('id',$id)->update($data);

        return redirect()->back()->with('success', 'Page Updated Successfully');
    }


    public function destroy($id)
    {
        $delete = Page::findOrFail($id);
		$image = $delete->page_image;
		if($delete->delete()){
			if(!empty($image)){
				if(file_exists($image)){
					unlink($image);
				}
			}
        }
        return redirect()->back()->with('success','Page Deleted Successfully');
    
    }


   



}

