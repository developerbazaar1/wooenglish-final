<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Subscription;
use App\Models\Planperiod;

class subscriptionController extends Controller
{
   
    public function index()
    {
        $plan_periods = Planperiod::orderBy('id','ASC')->get();
        $subscriptions = Subscription::orderBy('id','DESC')->get();
        return view('admin.subscription.index',compact('subscriptions','plan_periods'));
    }

    
    public function create()
    {
        return view('admin.subscription.create');
    }

    
    public function store(Request $request)
    { 
        $validated = $request->validate([
            'plan_name' => 'required',
            'plan_duration' => 'required',
            'plan_period' => 'required',
            'plan_price' => 'required',
        ]);

        if($request->input('status') == 'on'){
            $status = 'active';
        }else{
            $status = 'inactive';
        } 

        $data = array(
            "plan_name"=>$request->input('plan_name'),
            "plan_duration"=>$request->input('plan_duration'),
            "plan_period"=>$request->input('plan_period'),
            "plan_price"=>$request->input('plan_price'),
            "status"=>$status,
        );
        
        $id = Subscription::create($data)->id;
        return redirect('subscriptions')->with('success_add', 'Subscription Added Successfully');
    
    }

    
    public function show($id)
    {
        //
    }

    
    public function edit($id)
    {
        
        $subscriptions = Subscription::where('id',$id)->first();
        if(!empty($subscriptions)){
            return view('admin.subscription.edit',compact('subscriptions'));
        }else{
            return redirect()->back()->with('error', 'Subscription not added, please try again. ');
           
        }
    }

    
    public function update(Request $request)
    { 
        
        $id = $request->subscription_id;
        $subscription = Subscription::find($id);
        
        $data = array(
            "name"=>$request->subscription_name, 
        );
                    
        Subscription::where('id',$id)->update($data);

        return response()->json(['success'=>'Subscription edited successfully.']);
    }

    
    public function destroy($id)
    {
        $delete = Subscription::findOrFail($id);
		$image = $delete->subscription_image;
		if($delete->delete()){
			if(!empty($image)){
				if(file_exists($image)){
					unlink($image);
				}
			}
        }
        return redirect('subscriptions')->with('success','subscription Deleted Successfully');
    
    }


    public function changesubscriptionStatus(Request $request)

    {
        $id = $request->subscription_id;
        $subscription = Subscription::find($id);

        if($request->status == '1'){
            $data = array(
                "status"=>'active', 
            );
        }else{
            $data = array(
                "status"=>'inactive', 
            );
        }            
          
        Subscription::where('id',$id)->update($data);

        return response()->json(['success'=>'Status change successfully.']);

    }



}

