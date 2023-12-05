<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use Illuminate\Http\Request;
use App\Models\Favorite;
use App\Models\Follow;
use App\Models\Review;
use App\Models\Notification;
use App\Models\Announcement;
use App\Models\Page;
use App\Models\InfoPage;
use App\Models\Bookmark;
use App\Models\Support;
use App\Models\Feedback;
use App\Models\ViewBook;
use App\Models\Book;
use App\Models\Level;
use App\Models\Genre;
use App\Models\Length;
use App\Models\Language;
use App\Models\Chapter;
use App\Models\Subscription;
use App\Models\TranscationHistory;
use DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    
   public function index(Request $request)
    {   
        $user = User::where('id', Auth::user()->id )->first(); 
        $user_id = $user->user_id;
        $fbook = ViewBook::where('user_id', $user_id)->where('status', 'finish')->orderBy('id','DESC')->get();
        $completedbook = count($fbook);
        
        $vbook = ViewBook::where('user_id', $user_id)->orderBy('id','DESC')->get();
        $my_collection = count($vbook);
        
        $ongoing = $my_collection - $completedbook;
        $bookcount = array(
            'my_collection' => $my_collection,
            'completedbook' => $completedbook,
            'ongoing' => $ongoing,
            
            );
        
        if($user){
            $sanctumToken1 = $request->header('Authorization');
            $sanctumToken = substr($sanctumToken1, 7);
            return response()->json([
                'status' => true,
                'message' => 'Get user data successfully',
                'user' => $user,
                'bookcount' => $bookcount,
                'token' => $sanctumToken,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'User not exist, please try again',
            ], 400);
        }
       
    }

     public function get_user_favorite_data(Request $request)
    {
            if ($request->has('limit')) {
                $limit = $request->input('limit');
            }else{
                $limit = 10;
            }
            
            if ($request->has('offset')) {
                $offset = $request->input('offset');
            }else{
                $offset = 0;
            }
            
              if ($request->has('genre')) {
                $data['genre'] = $request->input('genre'); 
            }else{
                $data['genre'] = array();
            }
            
            if ($request->has('length')) {
                $data['length'] = $request->input('length'); 
            }else{
                $data['length'] = array();
            }
            
            if ($request->has('language')) {
                $data['language'] = $request->input('language'); 
            }else{
                $data['language'] = array();
            }
            
            if ($request->has('level')) {
                $data['level'] = $request->input('level'); 
            }else{
                $data['level'] = array();
            } 
            
            if ($request->has('is_audio')) {
                $data['is_audio'] = $request->input('is_audio'); 
            }else{
                $data['is_audio'] = array();
            } 
            
            if ($request->has('is__dashboard')) {
                $isDashboard = $request->input('is__dashboard');
            }else{
                $isDashboard = 0;
            }
            
            if($isDashboard == 1){
                $favorites = Favorite::with('bookdetails')->where('user_id',  Auth::user()->user_id)->orderBy('id','DESC')->skip(0)->take(4)->get();
            }else{
                $favorites = Favorite::with('bookdetails')->where('user_id',  Auth::user()->user_id)->orderBy('id','DESC')->skip($offset)->take($limit)->get();
            }
            
            
            if($favorites){
                $genre = Genre::orderBy('id','DESC')->get();
                $length = Length::orderBy('id','DESC')->get();
                $language  = Language::orderBy('id','DESC')->get();
                $level= Level::orderBy('id','DESC')->get();
                
                return response()->json([
                    'status' => true,
                    'message' => 'Get user favorite data successfully',
                    'books' => $favorites,
                    'genre' => $genre,
                    'length' => $length,
                    'language' => $language,
                    'level' => $level,
                ], 200);
            }else{
                return response()->json([
                    'status' => false,
                    'message' => 'No user favorite data available, please try again',
                ], 401);
            }
       
    }

    public function favorite_book(Request $request)
    {
        try {

            $validateUser = Validator::make($request->all(), 
            [
                'book_id' => 'required',
        
         
            ]);

            if($validateUser->fails()){
                return response()->json([
                    'status' => false,
                    'message' => 'validation error',
                    'errors' => $validateUser->errors()
                ], 401);
            }

            $fav = Favorite::where('user_id', Auth::user()->user_id)->where('book_id', $request->book_id)->first();

            if($fav){
                $fav->delete();

                return response()->json([
                    'status' => true,
                    'message' => 'Book deleted from favorite successfully',

                ], 200);

            }else{

                $favoritedata = Favorite::create([
                    'book_id' => $request->book_id,
                    'user_id' => Auth::user()->user_id,
                   
                ]);

                
                return response()->json([
                    'status' => true,
                    'message' => 'favorite book added successfully',
                    // 'favoritedata' => $favoritedata,
                ], 200);

            }
        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }

    public function follow_author(Request $request)
    {
        try {

            $validateUser = Validator::make($request->all(), 
            [
                'author_id' => 'required',
                
         
            ]);

            if($validateUser->fails()){
                return response()->json([
                    'status' => false,
                    'message' => 'validation error',
                    'errors' => $validateUser->errors()
                ], 401);
            }

            $follow = Follow::where('user_id', Auth::user()->user_id)->where('author_id', $request->author_id)->first();

            if($follow){
                $follow->delete();

                return response()->json([
                    'status' => true,
                    'message' => 'Author unfollowed successfully',

                ], 200);

            }else{
                $followdata = Follow::create([
                    'author_id' => $request->author_id,
                    'user_id' => Auth::user()->user_id,
                   
                ]);

                return response()->json([
                    'status' => true,
                    'message' => 'Author followed successfully',
                    // 'followdata' => $followdata,
                ], 200);
            }
            


        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }

    public function post_user_review(Request $request)
    {
        try {
            
            if(empty($request->book_id) || empty($request->rating)){
                return response()->json([
                    'status' => false,
                    'message' => 'All fields required',
                ], 400);

            }
            
            $reviewdata = Review::create([
                'book_id' => $request->book_id,
                'user_id' => Auth::user()->user_id,
                'rating' => $request->rating,
                'review' => $request->review,
                'name' =>  Auth::user()->name,
               
            ]);
            
            $book = Book::with('ratings')->find($request->book_id);

            $averageRating = $book->ratings->avg('rating');
            
            $data = array(
                "rating"=> $averageRating, 
            );
           
            Book::where('id',$request->book_id)->update($data);
            
            return response()->json([
                'status' => true,
                'message' => 'Success',
                // 'reviewdata' => $reviewdata,
            ], 200);
            
            


        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }


    public function get_announcement()
    {
        $announcements = Announcement::get();
        if($announcements){
            return response()->json([
                'status' => true,
                'message' => 'Get announcements data successfully',
                'announcement' => $announcements,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'announcement not exist, please try again',
            ], 401);
        }
       
    }

    public function get_notification(Request $request)
    {
        if ($request->has('limit')) {
            $limit = $request->input('limit');
        }else{
            $limit = 10;
        }
        
        if ($request->has('offset')) {
            $offset = $request->input('offset');
        }else{
            $offset = 0;
        }
        
        
        $notification = Notification::skip($offset)->take($limit)->get();
        if($notification){
            return response()->json([
                'status' => true,
                'message' => 'Success',
                'notification' => $notification,
            ], 200);
        }else{
            return response()->json([
                'status' => true,
                'message' => 'No data found!',
            ], 200);
        }
       
    }

    public function get_pages(Request $request)
    {
        if ($request->has('page_name')) {
            $page_name = $request->input('page_name');
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Page name required, please try again',
            ], 401);
        }
            
        $page = Page::where('page_name', $page_name)->first();
        if($page){
            return response()->json([
                'status' => true,
                'message' => 'Get page data successfully',
                'page' => $page,
            ], 200);
        }else{
            return response()->json([
                'status' => true,
                'message' => 'page not exist, please try again',
            ], 200);
        }
       
    }
    
    public function get_infopages(Request $request)
    {
        
        $pages = InfoPage::get();
        if($pages){
            return response()->json([
                'status' => true,
                'message' => 'Get page data successfully',
                'pages' => $pages,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'page not exist, please try again',
            ], 401);
        }
       
    }

    public function my_review(Request $request)
    {
        if ($request->has('limit')) {
            $limit = $request->input('limit');
        }else{
            $limit = 10;
        }
        
        if ($request->has('offset')) {
            $offset = $request->input('offset');
        }else{
            $offset = 0;
        }
        
        $reviews = Review::with('bookdetails')->with('userdetails')->where('user_id', Auth::user()->user_id)->skip($offset)->take($limit)->get();
        if($reviews){
            
            $ffbooks = Book::with('favorites')->where('status', 'active')->orderBy('id','DESC')->get();

            $a = array();
            foreach ($ffbooks as $pbook) {
          
                foreach ($pbook->favorites as $fav) {
    
                    if($fav->user_id == auth::user()->user_id){ 
                        array_push($a, $fav->book_id);
                    }
                    
                }
            }
            return response()->json([
                'status' => true,
                'message' => 'Get reviews data successfully',
                'reviews' => $reviews,
                'favorite' => $a,
            ], 200);
        }else{
            return response()->json([
                'status' => true,
                'message' => 'No data found!',
                'reviews' => [],
            ], 200);
        }
       
    }
    public function support(Request $request)
    {
        try {
            
             if(empty($request->msg)){
                return response()->json([
                    'status' => false,
                    'message' => 'Please write something for us!!',
                ], 400);

            }

            

            $user = User::where('user_id', Auth::user()->user_id)->first();
            if($user){
                $supportData = Support::create([
                    'msg' => $request->msg,
                    'user_id' => Auth::user()->user_id,
                    'name' => $user->name,
                    'email' => $user->email,
                ]);

                return response()->json([
                    'status' => true,
                    'message' => 'Your request has been submited!',
                ], 200);
            }else{
                return response()->json([
                    'status' => false,
                    'message' => 'user not exist, please try again',
                ], 401);
            }
            

            
            

            
        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }
    
    public function firebase_token(Request $request)
    {
        try {
            
             if(empty($request->fcmid)){
                return response()->json([
                    'status' => false,
                    'message' => 'Please pass valid fcmid!',
                ], 400);

            }

            $user = User::where('user_id', Auth::user()->user_id)->first();
            if($user){
                
                $data = array(
                     'fcmid' => $request->fcmid,
                );
                
                $userid = auth::user()->id;
                User::where('id',$userid)->update($data);
            
                return response()->json([
                    'status' => true,
                    'message' => 'Success',
                ], 200);
            }else{
                return response()->json([
                    'status' => false,
                    'message' => 'Please pass valid fcmid',
                ], 401);
            }
            

            
            

            
        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }
    
     public function feedback(Request $request)
    {
        try {
            
             if(empty($request->msg)){
                return response()->json([
                    'status' => false,
                    'message' => 'Please write something for us!!',
                ], 400);

            }

            

            $user = User::where('user_id', Auth::user()->user_id)->first();
            if($user){
                $feedbackData = Feedback::create([
                    'msg' => $request->msg,
                    'user_id' => Auth::user()->user_id,
                    'name' => $user->name,
                    'email' => $user->email,
                ]);

                return response()->json([
                    'status' => true,
                    'message' => 'Feedback submitted successfully!',
                ], 200);
            }else{
                return response()->json([
                    'status' => false,
                    'message' => 'user not exist, please try again',
                ], 401);
            }
            

            
            

            
        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }

    public function bookmark_book(Request $request)
    {
        try {

            $validateUser = Validator::make($request->all(), 
            [
                'book_id' => 'required',
                'chapter_id' => 'required',
         
            ]);

            $user_id = auth::user()->user_id;
            if($validateUser->fails()){
                return response()->json([
                    'status' => false,
                    'message' => 'validation error',
                    'errors' => $validateUser->errors()
                ], 401);
            }

            $bmark = Bookmark::where('user_id', $user_id)->where('book_id', $request->book_id)->where('chapter_id', $request->chapter_id)->first();

            if($bmark){
                $bmark->delete();

                return response()->json([
                    'status' => true,
                    'message' => 'Book deleted from bookmark successfully',

                ], 200);

            }else{
                
                $ch = Chapter::where('book_id', $request->book_id)->where('id', $request->chapter_id)->first();
                $bookmarkdata = Bookmark::create([
                    'book_id' => $request->book_id,
                    'chapter_id' => $request->chapter_id,
                    'chapter_name' => $ch->chapter_name,
                    'user_id' => $user_id,
                   
                ]);

                
                return response()->json([
                    'status' => true,
                    'message' => 'Bookmark book added successfully',
                    'bookmarkdata' => $bookmarkdata,
                ], 200);

            }
        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }

    public function get_bookmarks(Request $request)
    {
        
            if ($request->has('limit')) {
                $limit = $request->input('limit');
            }else{
                $limit = 10;
            }
            
            if ($request->has('offset')) {
                $offset = $request->input('offset');
            }else{
                $offset = 0;
            }
            
            $bookmarkdata = Bookmark::with('bookdetails')->where('user_id', Auth::user()->user_id)->orderBy('id','DESC')->skip($offset)->take($limit)->get();
            if($bookmarkdata){
                
                $ffbooks = Book::with('favorites')->where('status', 'active')->orderBy('id','DESC')->get();

                $a = array();
                foreach ($ffbooks as $pbook) {
              
                    foreach ($pbook->favorites as $fav) {
        
                        if($fav->user_id == auth::user()->user_id){ 
                            array_push($a, $fav->book_id);
                        }
                        
                    }
                }
                
                return response()->json([
                    'status' => true,
                    'message' => 'Get user bookmark  data successfully',
                    'books' => $bookmarkdata,
                    'favorite' => $a,
                ], 200);
            }else{
                return response()->json([
                    'status' => false,
                    'message' => 'No user bookmark data available, please try again',
                ], 401);
            }
       
    }
    
     public function update_profile(Request $request)
    {

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
                $image_path = public_path('upload/user');
                $request->document->move($image_path, $fileName);
                $formInput['document'] = 'upload/user/'.$fileName;
            }
            unset($formInput['document_old']);
        }else{
            $formInput['document'] = $request->input('document_old');
        }
        
       
        
        if(empty($request->name) || empty($request->country_code)){
            return response()->json([
                'status' => false,
                'message' => 'All fields required!',
            ], 400);

        }
        
       
        
        
        $data = array(
            "name"=>$request->input('name'),
            "country_code"=>$request->input('country_code'),
            "user_image"=>$formInput['document'],
        );
        
     
            $userid = auth::user()->id;  
            User::where('id',$userid)->update($data);
           
            return response()->json([
                    'status' => true,
                    'message' => 'Profile updated successfully',

                ], 200);
            
           
    }
    
    
    public function notification_on_off(Request $request)
    {
        
            if ($request->has('notification')) {
                $notification = $request->input('notification');
            }else{
                return response()->json([
                    'status' => false,
                    'message' => 'Notifiation required, please try again',
                ], 401);
            }
            
            $data = array(
                "notification_on_off"=>$notification,
            );
            
           
            $userid = auth::user()->id;
            $ndata = User::where('id',$userid)->update($data);
            
      
            return response()->json([
                'status' => true,
                'message' => 'Success',
                'data' => $notification,
            ], 200);
            
       
    }
    
     public function app_update(Request $request)
    {
        
            if ($request->has('app_update')) {
                $app_update = $request->input('app_update');
            }else{
                return response()->json([
                    'status' => false,
                    'message' => 'App update field required, please try again',
                ], 401);
            }
            
         
            $data = array(
                "app_update_on_off"=>$app_update,
            );
            
           
            $userid = auth::user()->id;
            User::where('id',$userid)->update($data);
            return response()->json([
                'status' => true,
                'message' => 'Success',
                'data' => $app_update,
            ], 200);
            
            
       
    }
    
       public function mode_change(Request $request)
    {
        
            if ($request->has('mode')) {
                $mode = $request->input('mode');
            }else{
                return response()->json([
                    'status' => false,
                    'message' => 'Mode field required, please try again',
                ], 401);
            }
            
         
            $data = array(
                "mode"=>$mode,
            );
            
           
            $userid = auth::user()->id;
            User::where('id',$userid)->update($data);
            return response()->json([
                'status' => true,
                'message' => 'Success',
                'data' => $mode,
            ], 200);
            
            
       
    }
    
    public function get_greeting(Request $request)
    {
        
        $user_ip = $_SERVER['REMOTE_ADDR'];

        // Send API request to ip-api.com
        $api_url = "http://ip-api.com/json/{$user_ip}";
        $response = file_get_contents($api_url);
        
        // Decode the response JSON
        $data = json_decode($response, true);
        
        // Extract country and timezone
        $country = $data['country'];
        $timezone = $data['timezone'];
        
        // Output the country and timezone
         "Country: " . $country . "<br>";
         "Timezone: " . $timezone;  

        // Set the default time zone
        date_default_timezone_set($timezone);
        
        // Get the current time
         $current_time = date('H:i');
        
        // Define the time ranges and corresponding greetings
        $time_ranges = array(
            array('start' => '05:00', 'end' => '11:59', 'greeting' => 'Good morning'),
            array('start' => '12:00', 'end' => '16:59', 'greeting' => 'Good afternoon'),
            array('start' => '17:00', 'end' => '23:59', 'greeting' => 'Good evening'),
            array('start' => '00:00', 'end' => '04:59', 'greeting' => 'Good night')
        );
        
        // Determine the greeting based on the current time
        $greeting = '';
        foreach ($time_ranges as $range) {
            if ($current_time >= $range['start'] && $current_time <= $range['end']) {
                $greeting = $range['greeting'];
                break;
            }
        }
        
        // Output the greeting
        if($greeting){
             return response()->json([
                'status' => true,
                'message' => 'Success',
                'data' => $greeting,
            ], 200);
        }else{
            return response()->json([
                'status' => true,
                'message' => 'Success',
                'data' => 'Welcome',
            ], 200);
        }
    }
    
    
     public function payment_update(Request $request)
    {
        
        try {
            
            if(empty($request->plan_id) || empty($request->amount) || empty($request->currency) || empty($request->status) || empty($request->transaction_id)){
                return response()->json([
                    'status' => false,
                    'message' => 'All fields required',
                ], 400);

            }
            
            
            

            $user = User::where('user_id', Auth::user()->user_id)->first();
            if($user){
                
                $subscription = Subscription::where('status', 'active' )->where('id', $request->plan_id )->first(); 
       
        
                if($subscription){
                   
                    if($request->amount == $subscription->plan_price){
                        
                        $tranData = TranscationHistory::create([
                            'plan_id' => $request->plan_id,
                            'user_id' => Auth::user()->user_id,
                            'amount' => $request->amount,
                            'currency' => $request->currency,
                            'status' => $request->status,
                            'transaction_id' => $request->transaction_id,
                            
                        ]);
                        
                        $plan_duration = $subscription->plan_duration;
                        $plan_period = $subscription->plan_period;
                        
                        $todays_date = date("d-m-Y");
        
                        if($plan_period == 'days'){
                            
                            $date = strtotime($todays_date);
                            $date = strtotime("+".$plan_duration." day", $date);
                            $membership_expire_date = date('d-m-Y', $date);
                        }else if($plan_period == 'months'){
                            
                            $date = strtotime($todays_date);
                            $date = strtotime("+".$plan_duration." months", $date);
                            $membership_expire_date = date('d-m-Y', $date);
                        }else{
                            
                            $date = strtotime($todays_date);
                            $date = strtotime("+".$plan_duration." years", $date);
                            $membership_expire_date = date('d-m-Y', $date);
                        }
                        
                        if($tranData){
                            $data = array(
                                "membership_plan"=> $request->plan_id,
                                "membership_date"=> $todays_date,
                                "membership_expire_date"=> $membership_expire_date,
                            );
                            
                           
                            $userid = auth::user()->id;
                            User::where('id',$userid)->update($data);
                        }
                        
                        return response()->json([
                            'status' => true,
                            'message' => 'Your request has been updated successfully!',
                        ], 200);
                        
                    }else{
                        return response()->json([
                            'status' => false,
                            'message' => 'subscriptions amount does not match with plan, please check and try again',
                        ], 400);
                    }
                
                }else{
                    return response()->json([
                        'status' => false,
                        'message' => 'subscriptions not exist, please try again',
                    ], 400);
                }
        
                
            }else{
                return response()->json([
                    'status' => false,
                    'message' => 'user not exist, please try again',
                ], 401);
            }
            

            
            

            
        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }
    

}
