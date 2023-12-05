<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Category;

class CategoryController extends Controller
{
   
    public function index()
    {
        $categories = Category::orderBy('id','DESC')->get();
        return view('admin.category.index',compact('categories'));
    }

    
    public function create()
    {
        return view('admin.category.create');
    }

    
    public function store(Request $request)
    { 
        $validated = $request->validate([
            'category_name' => 'required',
        ]);

        $data = array(
            "name"=>$request->input('category_name'),
        );
        
        $id = Category::create($data)->id;
        return redirect('categories')->with('success_add', 'Category Added Successfully');
    
    }

    
    public function show($id)
    {
        //
    }

    
    public function edit($id)
    {
        
        $categories = Category::where('id',$id)->first();
        if(!empty($categories)){
            return view('admin.category.edit',compact('categories'));
        }else{
            return redirect()->back()->with('error', 'Category not added, please try again. ');
           
        }
    }

    
    public function update(Request $request)
    { 
        
        $id = $request->category_id;
        $category = Category::find($id);
        
        $data = array(
            "name"=>$request->category_name, 
        );
                    
        Category::where('id',$id)->update($data);

        return response()->json(['success'=>'Category edited successfully.']);
    }

    
    public function destroy($id)
    {
        $delete = Category::findOrFail($id);
		$image = $delete->category_image;
		if($delete->delete()){
			if(!empty($image)){
				if(file_exists($image)){
					unlink($image);
				}
			}
        }
        return redirect('categories')->with('success','Category Deleted Successfully');
    
    }


    public function changeCategoryStatus(Request $request)

    {
        $id = $request->category_id;
        $category = Category::find($id);

        if($request->status == '1'){
            $data = array(
                "status"=>'active', 
            );
        }else{
            $data = array(
                "status"=>'inactive', 
            );
        }            
          
        Category::where('id',$id)->update($data);

        return response()->json(['success'=>'Status change successfully.']);

    }



}

