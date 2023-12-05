<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use App\Models\UserOtp;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use DB;

class AuthController extends Controller
{
    
    public function createUser(Request $request)
    {
        try {

           
            if(empty($request->name) || empty($request->mobile) ||  empty($request->email) || empty($request->device_type) || empty($request->country_code)){
                return response()->json([
                    'status' => false,
                    'message' => 'All fields required!',
                ], 400);

            }

            if($request->mobile){
                $validateUser = Validator::make($request->all(), 
                [
                    'mobile' => 'unique:users,mobile',
             
                ]);

                if($validateUser->fails()){ 
                   
                    return response()->json([
                        'status' => false,
                        'message' => 'Mobile has already been taken!',
                    ], 400);
                } 

            } 

            if($request->email){

                $validateUser = Validator::make($request->all(), 
                [
                    'email' => 'email',
             
                ]);

                if($validateUser->fails()){ 
                   
                    return response()->json([
                        'status' => false,
                        'message' => 'Please enter valid email!',
                    ], 400);
                } 


            }

            if($request->email){

                $validateUser = Validator::make($request->all(), 
                [
                    'email' => 'unique:users,email',
             
                ]);

                if($validateUser->fails()){ 
                   
                    return response()->json([
                        'status' => false,
                        'message' => 'Email has already been taken!',
                    ], 400);
                } 

               
            }


            $user = User::create([
                'name' => $request->name,
                // 'email' => $request->email,
                'device_type' => $request->device_type,
                'country_code' => $request->country_code,
                'mobile' => $request->mobile,
                'user_id' => uniqid(),
                'password' => Hash::make(rand(1234, 9999))
            ]);

            $userOtp = $this->generateOtp($request->mobile);

            $user = User::where('mobile', $request->mobile)->first();
          
            return response()->json([
                'status' => true,
                'message' => 'Register successfully',
                'user_id' => $user->user_id,
                'otp' => $userOtp['otp'],
            ], 200);


        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }


    public function loginUser(Request $request)
    {
        try {

            if(empty($request->mobile)){
                return response()->json([
                    'status' => false,
                    'message' => 'All fields required!',
                ], 400);

            }

            if($request->mobile){
                $validateUser = Validator::make($request->all(), 
                [
                    'mobile' => 'numeric',
             
                ]);

                if($validateUser->fails()){ 
                   
                    return response()->json([
                        'status' => false,
                        'message' => 'Please enter a valid number!',
                    ], 400);
                } 

            } 

           
            $user = User::where('mobile', $request->mobile)->first();

            if(!$user){
                return response()->json([
                    'status' => false,
                    'message' => 'Mobile number does not match with our record.',
                ], 400);
            }


            $userOtp = $this->generateOtp($request->mobile);

            return response()->json([

                'status' => true,
                'message' => 'OTP send successfully',
                'user_id' => $user->user_id,
                'otp' => $userOtp['otp'],
            ], 200);


        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }


    public function generateOtp($mobile)
    {

        $user = User::where('mobile', $mobile)->first();

        $userOtp = UserOtp::where('user_id', $user->user_id)->latest()->first();

        $now = now();

        if($userOtp && $now->isBefore($userOtp->expire_at)){
            return $userOtp;
        }

        return UserOtp::create([

            'user_id' => $user->user_id,

            'otp' => rand(1234, 9999),

            'expire_at' => $now->addMinutes(10)

        ]);

    }


    public function loginWithOtp(Request $request)
    {

        if(empty($request->otp) || empty($request->user_id) ){
            return response()->json([
                'status' => false,
                'message' => 'All fields required!',
            ], 400);

        }
        
        if($request->is_required == 1){
                $validateUser = Validator::make($request->all(), 
                [
                    'email' => 'required|unique:users,email',
                    'country_code' => 'required'
                ]);

                if($validateUser->fails()){ 
                   
                    return response()->json([
                        'status' => false,
                        'message' => $validateUser->errors(),
                    ], 400);
                } 
        }
        

        $request->validate([
            'user_id' => 'required|exists:users,user_id',
            'otp' => 'required'
        ]);  

        $userOtp   = UserOtp::where('user_id', $request->user_id)->where('otp', $request->otp)->first();

        $now = now();

        if (!$userOtp) { 
            return response()->json([
                'status' => false,
                'message' => 'Please enter valid OTP!'
            ], 400);

        }else if($userOtp && $now->isAfter($userOtp->expire_at)){
            return response()->json([
                'status' => false,
                'message' => 'Your OTP has been expired'
            ], 400);
        }

        $ip = '';
        if(!empty($_SERVER['HTTP_CLIENT_IP'])) {  
                $ip = $_SERVER['HTTP_CLIENT_IP'];  
        } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {  
                    $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];  
        } else{  
                 $ip = $_SERVER['REMOTE_ADDR'];  
        }  
        
        
        if($request->is_required == 1){
            $new_arr = array(
                'ip' => $ip,
                'email' => $request->email,
                'country_code' => $request->country_code,
            );
    
            User::where('user_id', $request->user_id)->update($new_arr);
        }else{
            $new_arr = array(
                'ip' => $ip,
               
            );
    
            User::where('user_id', $request->user_id)->update($new_arr);
        }
        
        

        $user = User::where('user_id', $request->user_id)->first();

        if($user){

            $userOtp->update([
                'expire_at' => now()
            ]);

            
            return response()->json([
                'status' => true,
                'message' => 'User Login Successfully',
                'user' => $user,
                'token' => $user->createToken("API TOKEN")->plainTextToken
            ], 200);
           
        }

        return response()->json([
                'status' => false,
                'message' => 'Your Otp is not correct'
            ], 400);
    }

    
    
     public function sso(Request $request)
    {

        if(empty($request->name) || empty($request->email) || empty($request->provider) || empty($request->device_type)){
            return response()->json([
                'status' => false,
                'message' => 'All fields required!',
            ], 400);

        }

        

        $request->validate([
            'name' => 'required',
            'email' => 'required',
             'provider' => 'required'
        ]);  

        $user1 = User::where('email', $request->email)->first();
        if($user1){
            $user_id = $user1->user_id; 
            
            $data = array(
                'provider' => $request->provider,
                'device_type' => $request->device_type,
            );
            
            User::where('user_id',$user_id)->update($data);
            
        }else{
            $user1 = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'provider' => $request->provider,
                'device_type' => $request->device_type,
                'user_id' => uniqid(),
                'password' => Hash::make(rand(1234, 9999))
            ]);
            
            $user1 = User::where('email', $request->email)->first();
            $user_id = $user1->user_id;
        }
             
        $ip = '';
        if(!empty($_SERVER['HTTP_CLIENT_IP'])) {  
                $ip = $_SERVER['HTTP_CLIENT_IP'];  
        } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {  
                    $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];  
        } else{  
                 $ip = $_SERVER['REMOTE_ADDR'];  
        }  

        $new_arr = array(
            'ip' => $ip,
        );

        User::where('user_id', $user_id)->update($new_arr);

        $user2 = User::where('user_id', $user_id)->first();

        if($user2){

            return response()->json([
                'status' => true,
                'message' => 'User Login Successfully',
                'user' => $user2,
                'token' => $user2->createToken("API TOKEN")->plainTextToken
            ], 200);
           
        }

        return response()->json([
                'status' => false,
                'message' => 'something wrong, please try again'
            ], 400);
    }
    
     public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Logged out successfully']);
    }

    
   

}
