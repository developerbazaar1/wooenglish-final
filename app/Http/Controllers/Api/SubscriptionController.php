<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use Illuminate\Http\Request;
use App\Models\Subscription;
use App\Models\Planperiod;
use DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class SubscriptionController extends Controller
{
    
   public function index(Request $request)
    {   
        $subscriptions = Subscription::where('status', 'active' )->get(); 
       
        
        if($subscriptions){
           
            return response()->json([
                'status' => true,
                'message' => 'Get subscriptions data successfully',
                'subscription' => $subscriptions,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'subscriptions not exist, please try again',
            ], 400);
        }
       
    }

}
