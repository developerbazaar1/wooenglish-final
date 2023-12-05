<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InfoPage;
use Illuminate\Support\Facades\Crypt;

class InfoPageController extends Controller
{
   
    public function index()
    {
        $pages = InfoPage::orderBy('id','DESC')->get();
        return view('admin.infopage.index',compact('pages'));
    }

    
    public function create()
    {
        return view('admin.infopage.create');
    }

    
    public function store(Request $request)
    { 
        $validated = $request->validate([
            'page_name' => 'required',
            'content' => 'required',
        ]);
        
         if($request->file('document')){
            $image = $request->file('document');
            if($image->isValid()){
                if(!empty($request->input('document_old'))){
                    if(file_exists(public_path('/').'/'.$request->input('document_old'))){
                        unlink(public_path('/').'/'.$request->input('document_old')); 
                    }
                }
                $extension = $image->getClientOriginalExtension();
                $fileName = rand(100,999999).time().'.'.$extension;
                $image_path = public_path('upload/infopage');
                $request->document->move($image_path, $fileName);
                $formInput['document'] = 'upload/infopage/'.$fileName;
            }
            unset($formInput['document_old']);
        }else{
            $formInput['document'] = $request->input('document_old');
        }
        
        $data = array(
            "page_name"=>$request->input('page_name'),
            "page_description"=>$request->input('content'),
            "image"=>$formInput['document'],
        );
        
        $id = InfoPage::create($data)->id;
        return redirect()->back()->with('success_add', 'Page Added Successfully');
    
    }

   
    public function edit($id)
    {
        $pageid = Crypt::decrypt($id); 
        $page = InfoPage::where('id',$pageid)->first();
        if(!empty($page)){
            return view('admin.infopage.edit',compact('page'));
        }else{
            return redirect()->back()->with('error','Page having error, try again');
        }
    }

    
    public function update(Request $request)
    { 
        
        $id = $request->pageid;
        $infopage = Infopage::find($id);
        
        if($request->file('document')){
            $image = $request->file('document');
            if($image->isValid()){
                if(!empty($request->input('document_old'))){
                    if(file_exists(public_path('/').'/'.$request->input('document_old'))){
                        unlink(public_path('/').'/'.$request->input('document_old')); 
                    }
                }
                $extension = $image->getClientOriginalExtension();
                $fileName = rand(100,999999).time().'.'.$extension;
                $image_path = public_path('upload/infopage');
                $request->document->move($image_path, $fileName);
                $formInput['document'] = 'upload/infopage/'.$fileName;
            }
            unset($formInput['document_old']);
        }else{
            $formInput['document'] = $request->input('document_old');
        }
        
        $data = array(
            "page_name"=>$request->page_name, 
            "page_description"=>$request->content, 
            "image"=>$formInput['document'],
        );
                    
        InfoPage::where('id',$id)->update($data);

        return redirect()->back()->with('success', 'Page Updated Successfully');
    }


    public function destroy($id)
    {
        $delete = InfoPage::findOrFail($id);
		$image = $delete->image;
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

