<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Author;

class AuthorController extends Controller
{
   
    public function index()
    {
        $authors = Author::orderBy('id','DESC')->get();
        return view('admin.author.index',compact('authors'));
    }

    
    public function create()
    {
        return view('admin.author.create');
    }

    
    public function store(Request $request)
    { 
        $validated = $request->validate([
            'author_name' => 'required',
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
                $image_path = public_path('upload/author');
                $request->document->move($image_path, $fileName);
                $formInput['document'] = 'upload/author/'.$fileName;
            }
            unset($formInput['document_old']);
        }else{
            $formInput['document'] = $request->input('document_old');
        }

        $data = array(
            "name"=>$request->input('author_name'),
            "author_image"=>$formInput['document'],
        );
        
        $id = Author::create($data)->id;
        return redirect('authors')->with('success_add', 'Author Added Successfully');
    
    }

    
    public function show($id)
    {
        //
    }

    
    public function edit($id)
    {
        $trans   = trans('admin');
        $authors = Author::where('id',$id)->first();
        if(!empty($authors)){
            return view('admin.author.edit',compact('authors'));
        }else{
            return redirect()->back()->with('error',$authors['author']['messages']['not_found']);
        }
    }

    
    public function update(Request $request)
    { 
        
        $id = $request->author_id;
        $author = Author::find($id);
        
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
                $image_path = public_path('upload/author');
                $request->document->move($image_path, $fileName);
                $formInput['document'] = 'upload/author/'.$fileName;
            }
            unset($formInput['document_old']);
        }else{
            $formInput['document'] = $request->input('document_old');
        }

        $data = array(
            "name"=>$request->author_name, 
            "author_image"=>$formInput['document'],
        );
                    
        Author::where('id',$id)->update($data);

        return response()->json([
                'status' => true,
                'success' => 'Author edited successfully.',
                'formdata' => $data
            ], 200);
    }

    
    public function destroy($id)
    {
        $delete = Author::findOrFail($id);
		$image1 = $delete->author_image;
		$image = "public/".$image1;
		if($delete->delete()){
			if(!empty($image)){
				if(file_exists($image)){
					unlink($image);
				}
			}
        }
        return redirect('authors')->with('success','author Deleted Successfully');
    
    }


    public function changeauthorStatus(Request $request)

    {
        $id = $request->author_id;
        $author = Author::find($id);

        if($request->status == '1'){
            $data = array(
                "status"=>'active', 
            );
        }else{
            $data = array(
                "status"=>'inactive', 
            );
        }            
          
        Author::where('id',$id)->update($data);

        return response()->json(['success'=>'Status change successfully.']);

    }



}

