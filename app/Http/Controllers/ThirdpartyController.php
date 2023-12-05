<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ThirdPartyData;
use Illuminate\Support\Facades\Crypt;

class ThirdpartyController extends Controller
{
   
    public function index()
    {

        $thirdparty = ThirdPartyData::first(); 
        return view('admin.thirdparty.index', compact('thirdparty'));
    }

    
    public function create()
    {
        return view('admin.thirdparty.create');
    }

    
    public function store(Request $request)
    { 
        $validated = $request->validate([
            'facebook_url' => 'required',
            'youtube_url' => 'required',
            'mob_id' => 'required',
            "paypal_id" => 'required',
        ]);

        $data = array(
            "facebook_url"=>$request->input('facebook_url'),
            "youtube_url"=>$request->input('youtube_url'),
            "mob_id"=>$request->input('mob_id'),
            "paypal_id"=>$request->input('mob_id'),
        );
        
        
        $thirdpartys = ThirdPartyData::first();
        if($thirdpartys){
            ThirdPartyData::where('id',$thirdpartys->id)->update($data);
        }else{
            $id = ThirdPartyData::create($data)->id;
        }
        
        return redirect()->back()->with('success_add', 'Thirdparty Data Added Successfully');
    
    }

    
   
    
    public function destroy($id)
    {
        $delete = ThirdPartyData::findOrFail($id);
		$image = $delete->thirdparty_image;
		if($delete->delete()){
			if(!empty($image)){
				if(file_exists($image)){
					unlink($image);
				}
			}
        }
        return redirect()->back()->with('success','Thirdparty Data Deleted Successfully');
    
    }

   

}

