<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use App\Models\Book;
use App\Models\Author;
use App\Models\Follow;
use App\Models\Review;
use App\Models\HomeCategory;
use App\Models\Chapter;
use App\Models\EnglishAccent;
use App\Models\Level;
use App\Models\Length;
use App\Models\Language;
use App\Models\Quiz;
use App\Models\Category;
use App\Models\ViewBook;
use App\Models\Bookmark;
use App\Models\Genre;
use App\Models\Favorite;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class BookController extends Controller
{
    
   public function get_popular(Request $request)
    {   
        $popular_data = HomeCategory::where('name', 'popular')->first();
        if($popular_data){
            
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
            
            // if ($request->has('genre')) {
            //     $data['genre'] = $request->input('genre'); 
            // }else{
            //     $data['genre'] = array();
            // }
            if ($request->has('genre')) {
                 $data['genre'] = $request->input('genre');
                 $exist = Genre::where('name', 'Any')->first();
                if($exist->id == $data['genre']){
                    $data['genre'] = array();
                }else{
                    $data['genre'] = $data['genre'];
                }
            }else{
                $data['genre'] = array();
            }
            
            // if ($request->has('length')) {
            //     $data['length'] = $request->input('length'); 
            // }else{
            //     $data['length'] = array();
            // }
            if ($request->has('length')) {
                 $data['length'] = $request->input('length');
                 $exist = Length::where('name', 'Any')->first();
                if($exist->id == $data['length']){
                    $data['length'] = array();
                }else{
                    $data['length'] = $data['length'];
                }
            }else{
                $data['length'] = array();
            }
            
            // if ($request->has('language')) {
            //     $data['language'] = $request->input('language'); 
            // }else{
            //     $data['language'] = array();
            // }
            if ($request->has('language')) {
                 $data['language'] = $request->input('language');
                 $exist = Language::where('name', 'Any')->first();
                if($exist->id == $data['language']){
                    $data['language'] = array();
                }else{
                    $data['language'] = $data['language'];
                }
            }else{
                $data['language'] = array();
            }
            
            // if ($request->has('level')) {
            //     $data['level'] = $request->input('level'); 
            // }else{
            //     $data['level'] = array();
            // } 
             if ($request->has('level')) {
                 $data['level'] = $request->input('level');
                 $exist = Level::where('name', 'Any')->first();
                if($exist->id == $data['level']){
                    $data['level'] = array();
                }else{
                    $data['level'] = $data['level'];
                }
            }else{
                $data['level'] = array();
            }
            
            if ($request->has('is_audio')) {
                $data['is_audio'] = $request->input('is_audio'); 
            }else{
                $data['is_audio'] = array();
            } 
           
            
            $popularbooks = Book::where('home_category', $popular_data->id)
            ->where('status', 'active')
            ->where('showbookto', 'all_users')
            ->when(!empty($data['genre']) , function ($query) use($data){
                return $query->where('genre',$data['genre']);
            })
            ->when(!empty($data['level']) , function ($query) use($data){
                return $query->where('level',$data['level']);
            })
             ->when(!empty($data['length']) , function ($query) use($data){
                return $query->where('length',$data['length']);
            })
             ->when(!empty($data['language']) , function ($query) use($data){
                return $query->where('language',$data['language']);
            })
             ->when(!empty($data['is_audio']) , function ($query) use($data){
                return $query->where('is_audio',$data['is_audio']);
            })
            ->orderBy('id','DESC')
            ->skip($offset)->take($limit)->get();

            if($popularbooks){
                
                $ffbooks = Book::with('favorites')->where('home_category', $popular_data->id)->where('status', 'active')->where('showbookto', 'all_users')->orderBy('id','DESC')->get();

                $a = array();
                foreach ($ffbooks as $pbook) {
              
                    foreach ($pbook->favorites as $fav) {
        
                        if($fav->user_id == auth::user()->user_id){ 
                            array_push($a, $fav->book_id);
                        }
                        
                    }
                }
                        
                $genre = Genre::orderBy('id','DESC')->get();
                $length = Length::orderBy('id','DESC')->get();
                $language  = Language::orderBy('id','DESC')->get();
                $level= Level::orderBy('id','DESC')->get();
                
                return response()->json([
                    'status' => true,
                    'message' => 'Get books data successfully',
                    'books' => $popularbooks,
                    'genre' => $genre,
                    'length' => $length,
                    'language' => $language,
                    'level' => $level,
                    'favorite' => $a,
                    
                ], 200);
            }else{
                return response()->json([
                    'status' => true,
                    'message' => 'No data found!',
                ], 200);
            }
        }else{
            return response()->json([
                'status' => false,
                'message' => 'No Category available, please try again',
            ], 401);
        }
        
       
    }

    public function get_recommended(Request $request)
    {
        $recommended_data = HomeCategory::where('name', 'recommended')->first();
        if($recommended_data){

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
                 $exist = Genre::where('name', 'Any')->first();
                if($exist->id == $data['genre']){
                    $data['genre'] = array();
                }else{
                    $data['genre'] = $data['genre'];
                }
            }else{
                $data['genre'] = array();
            }
            
            if ($request->has('length')) {
                 $data['length'] = $request->input('length');
                 $exist = Length::where('name', 'Any')->first();
                if($exist->id == $data['length']){
                    $data['length'] = array();
                }else{
                    $data['length'] = $data['length'];
                }
            }else{
                $data['length'] = array();
            }
            
            if ($request->has('language')) {
                 $data['language'] = $request->input('language');
                 $exist = Language::where('name', 'Any')->first();
                if($exist->id == $data['language']){
                    $data['language'] = array();
                }else{
                    $data['language'] = $data['language'];
                }
            }else{
                $data['language'] = array();
            }
          
             if ($request->has('level')) {
                 $data['level'] = $request->input('level');
                 $exist = Level::where('name', 'Any')->first();
                if($exist->id == $data['level']){
                    $data['level'] = array();
                }else{
                    $data['level'] = $data['level'];
                }
            }else{
                $data['level'] = array();
            }
            
            // if ($request->has('genre')) {
            //     $data['genre'] = $request->input('genre'); 
            // }else{
            //     $data['genre'] = array();
            // }
            
            // if ($request->has('level')) {
            //     $data['level'] = $request->input('level'); 
            // }else{
            //     $data['level'] = array();
            // }  
            
            // if ($request->has('length')) {
            //     $data['length'] = $request->input('length'); 
            // }else{
            //     $data['length'] = array();
            // }
            
            if ($request->has('is_audio')) {
                $data['is_audio'] = $request->input('is_audio'); 
            }else{
                $data['is_audio'] = array();
            }
            
            // if ($request->has('language')) {
            //     $data['language'] = $request->input('language'); 
            // }else{
            //     $data['language'] = array();
            // }

            $recommendedbooks = Book::where('home_category', $recommended_data->id)
            ->where('status', 'active')
            ->where('showbookto', 'all_users')
            ->when(!empty($data['genre']) , function ($query) use($data){
                return $query->where('genre',$data['genre']);
            })
            ->when(!empty($data['level']) , function ($query) use($data){
                return $query->where('level',$data['level']);
            })
              ->when(!empty($data['length']) , function ($query) use($data){
                return $query->where('length',$data['length']);
            })
             ->when(!empty($data['language']) , function ($query) use($data){
                return $query->where('language',$data['language']);
            })
             ->when(!empty($data['is_audio']) , function ($query) use($data){
                return $query->where('is_audio',$data['is_audio']);
            })
            ->orderBy('id','DESC')
            ->skip($offset)->take($limit)->get();

            if($recommendedbooks){
                $genre = Genre::orderBy('id','DESC')->get();
                $length = Length::orderBy('id','DESC')->get();
                $language  = Language::orderBy('id','DESC')->get();
                $level= Level::orderBy('id','DESC')->get();
                
                $ffbooks = Book::with('favorites')->where('home_category', $recommended_data->id)->where('status', 'active')->where('showbookto', 'all_users')->orderBy('id','DESC')->get();
                
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
                    'message' => 'Get books data successfully',
                    'books' => $recommendedbooks,
                    'genre' => $genre,
                    'length' => $length,
                    'language' => $language,
                    'level' => $level,
                    'favorite' => $a,
                ], 200);
            }else{
                return response()->json([
                    'status' => true,
                    'message' => 'No data found!',
                ], 200);
            }
        }else{
            return response()->json([
                'status' => false,
                'message' => 'No Category available, please try again',
            ], 401);
        }
        
       
    }

    public function get_new_release(Request $request)
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
                 $exist = Genre::where('name', 'Any')->first();
                if($exist->id == $data['genre']){
                    $data['genre'] = array();
                }else{
                    $data['genre'] = $data['genre'];
                }
            }else{
                $data['genre'] = array();
            }
            
            if ($request->has('length')) {
                 $data['length'] = $request->input('length');
                 $exist = Length::where('name', 'Any')->first();
                if($exist->id == $data['length']){
                    $data['length'] = array();
                }else{
                    $data['length'] = $data['length'];
                }
            }else{
                $data['length'] = array();
            }
            
            if ($request->has('language')) {
                 $data['language'] = $request->input('language');
                 $exist = Language::where('name', 'Any')->first();
                if($exist->id == $data['language']){
                    $data['language'] = array();
                }else{
                    $data['language'] = $data['language'];
                }
            }else{
                $data['language'] = array();
            }
          
             if ($request->has('level')) {
                 $data['level'] = $request->input('level');
                 $exist = Level::where('name', 'Any')->first();
                if($exist->id == $data['level']){
                    $data['level'] = array();
                }else{
                    $data['level'] = $data['level'];
                }
            }else{
                $data['level'] = array();
            }
            
            // if ($request->has('genre')) {
            //     $data['genre'] = $request->input('genre'); 
            // }else{
            //     $data['genre'] = array();
            // }
            
            // if ($request->has('level')) {
            //     $data['level'] = $request->input('level'); 
            // }else{
            //     $data['level'] = array();
            // }  
            
            // if ($request->has('length')) {
            //     $data['length'] = $request->input('length'); 
            // }else{
            //     $data['length'] = array();
            // }
            
            if ($request->has('is_audio')) {
                $data['is_audio'] = $request->input('is_audio'); 
            }else{
                $data['is_audio'] = array();
            }
            
            // if ($request->has('language')) {
            //     $data['language'] = $request->input('language'); 
            // }else{
            //     $data['language'] = array();
            // }
            
            if ($request->has('top_books')) {
                
                $ids = $newreleasebooks = Book::where('status', 'active')
                ->where('showbookto', 'all_users')->pluck('id')->toArray();
                
                $randomKeys1 = array_rand($ids, 3); 
                $randomKeys2  = array_map('strval', $randomKeys1);
                $data['randomKeys'] = array();
               
                array_push($data['randomKeys'], $ids[$randomKeys2[0]]);
                array_push($data['randomKeys'], $ids[$randomKeys2[1]]);
                array_push($data['randomKeys'], $ids[$randomKeys2[2]]);
                

                
            
            // var_dump($randomKeys);  var_dump($randomKeys2); die;
                $newreleasebooks = Book::where('status', 'active')
                ->where('showbookto', 'all_users')
                ->when(!empty($data['randomKeys']) , function ($query) use($data){
                    return $query->whereIn('id',$data['randomKeys']);
                })
                ->orderBy('id','DESC')
                ->get();
                
            }else{
                
            
                $newreleasebooks = Book::where('status', 'active')
                ->where('showbookto', 'all_users')
                ->when(!empty($data['genre']) , function ($query) use($data){
                    return $query->where('genre',$data['genre']);
                })
                ->when(!empty($data['level']) , function ($query) use($data){
                    return $query->where('level',$data['level']);
                })
                 ->when(!empty($data['length']) , function ($query) use($data){
                    return $query->where('length',$data['length']);
                })
                 ->when(!empty($data['language']) , function ($query) use($data){
                    return $query->where('language',$data['language']);
                })
                 ->when(!empty($data['is_audio']) , function ($query) use($data){
                    return $query->where('is_audio',$data['is_audio']);
                })
                
                ->orderBy('id','DESC')
                ->skip($offset)
                ->take($limit)->get();
             }

            if($newreleasebooks){
                $genre = Genre::orderBy('id','DESC')->get();
                $length = Length::orderBy('id','DESC')->get();
                $language  = Language::orderBy('id','DESC')->get();
                $level= Level::orderBy('id','DESC')->get();
                
                $ffbooks = Book::with('favorites')->where('status', 'active')->where('showbookto', 'all_users')->orderBy('id','DESC')->get();
                
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
                    'message' => 'Get new books data successfully',
                    'books' => $newreleasebooks,
                    'genre' => $genre,
                     'length' => $length,
                    'language' => $language,
                    'level' => $level,
                    'favorite' => $a,
                ], 200);
            }else{
                return response()->json([
                    'status' => true,
                    'message' => 'No data found!',
                ], 200);
            }
       
    }

    public function get_members_data(Request $request)
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
                 $exist = Genre::where('name', 'Any')->first();
                if($exist->id == $data['genre']){
                    $data['genre'] = array();
                }else{
                    $data['genre'] = $data['genre'];
                }
            }else{
                $data['genre'] = array();
            }
            
            if ($request->has('length')) {
                 $data['length'] = $request->input('length');
                 $exist = Length::where('name', 'Any')->first();
                if($exist->id == $data['length']){
                    $data['length'] = array();
                }else{
                    $data['length'] = $data['length'];
                }
            }else{
                $data['length'] = array();
            }
            
            if ($request->has('language')) {
                 $data['language'] = $request->input('language');
                 $exist = Language::where('name', 'Any')->first();
                if($exist->id == $data['language']){
                    $data['language'] = array();
                }else{
                    $data['language'] = $data['language'];
                }
            }else{
                $data['language'] = array();
            }
          
             if ($request->has('level')) {
                 $data['level'] = $request->input('level');
                 $exist = Level::where('name', 'Any')->first();
                if($exist->id == $data['level']){
                    $data['level'] = array();
                }else{
                    $data['level'] = $data['level'];
                }
            }else{
                $data['level'] = array();
            }
            
            // if ($request->has('genre')) {
            //     $data['genre'] = $request->input('genre'); 
            // }else{
            //     $data['genre'] = array();
            // }
            
            // if ($request->has('level')) {
            //     $data['level'] = $request->input('level'); 
            // }else{
            //     $data['level'] = array();
            // } 
            
            // if ($request->has('length')) {
            //     $data['length'] = $request->input('length'); 
            // }else{
            //     $data['length'] = array();
            // }
            
            if ($request->has('is_audio')) {
                $data['is_audio'] = $request->input('is_audio'); 
            }else{
                $data['is_audio'] = array();
            }
            
            // if ($request->has('language')) {
            //     $data['language'] = $request->input('language'); 
            // }else{
            //     $data['language'] = array();
            // }
        
            $membersbooks = Book::where('status', 'active')
            ->where('showbookto', 'paid_users')
            ->when(!empty($data['genre']) , function ($query) use($data){
                return $query->where('genre',$data['genre']);
            })
            ->when(!empty($data['level']) , function ($query) use($data){
                return $query->where('level',$data['level']);
            })
              ->when(!empty($data['length']) , function ($query) use($data){
                return $query->where('length',$data['length']);
            })
             ->when(!empty($data['language']) , function ($query) use($data){
                return $query->where('language',$data['language']);
            })
             ->when(!empty($data['is_audio']) , function ($query) use($data){
                return $query->where('is_audio',$data['is_audio']);
            })
            ->orderBy('id','DESC')
            ->skip($offset)->take($limit)->get();

            if($membersbooks){
                $genre = Genre::orderBy('id','DESC')->get();
                $length = Length::orderBy('id','DESC')->get();
                $language  = Language::orderBy('id','DESC')->get();
                $level= Level::orderBy('id','DESC')->get();
                
                $ffbooks = Book::with('favorites')->where('status', 'active')->where('showbookto', 'paid_users')->orderBy('id','DESC')->get();
                
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
                    'message' => 'Get member books data successfully',
                    'books' => $membersbooks,
                    'genre' => $genre,
                     'length' => $length,
                    'language' => $language,
                    'level' => $level,
                    'favorite' => $a,
                ], 200);
            }else{
                return response()->json([
                    'status' => true,
                    'message' => 'No data found!',
                ], 200);
            }
       
    }

    public function get_authors(Request $request)
    {
            if ($request->has('limit')) {
                $limit = $request->input('limit');
            }else{
                $limit = 50000;
            }
            
            if ($request->has('offset')) {
                $offset = $request->input('offset');
            }else{
                $offset = 0;
            }
            
            if ($request->has('for_dashboard')) {
                $for_dashboard = $request->input('for_dashboard');
            }else{
                $for_dashboard = 1;
            }
            
            if ($request->has('search')) {
                if(!empty($request->input('search'))){
                    $authorname  = $request->input('search');
                }else{
                    $authorname = '';
                }
                
                 $authors = Author::where('name', 'LIKE', '%' . $authorname . '%')->where('status', 'active')->orderBy('id','DESC')->skip($offset)->take($limit)->get();
                if($authors){
                    return response()->json([
                        'status' => true,
                        'message' => 'Get authors data successfully',
                        'authors' => $authors,
                    ], 200);
                }else{
                    return response()->json([
                        'status' => false,
                        'message' => 'No author available, please try again',
                    ], 401);
                }
                
            }else{
                
        
                $authors = Author::where('status', 'active')->orderBy('id','DESC')->skip($offset)->take($limit)->get();
                if($authors){
                    return response()->json([
                        'status' => true,
                        'message' => 'Get authors data successfully',
                        'authors' => $authors,
                    ], 200);
                }else{
                    return response()->json([
                        'status' => false,
                        'message' => 'No author available, please try again',
                    ], 401);
                }
            
            }
       
    }
    
    public function searchby_authorname(Request $request)
    {
            
            if ($request->has('author')) {
                if(!empty($request->input('author'))){
                    $authorname  = $request->input('author');
                }else{
                    $authorname = '';
                }
                
            }else{
                 return response()->json([
                    'status' => false,
                    'message' => 'Author name is requird',
                ], 401);
            }   
        
            $authors = Author::where('name', 'LIKE', '%' . $authorname . '%')->where('status', 'active')->orderBy('id','DESC')->get();
            if($authors){
                return response()->json([
                    'status' => true,
                    'message' => 'Get authors data successfully',
                    'authors' => $authors,
                ], 200);
            }else{
                return response()->json([
                    'status' => false,
                    'message' => 'No author available, please try again',
                ], 401);
            }

        
    }
    
    
    public function add_view_count(Request $request)
    {       
        if(empty($request->book_id)){
            return response()->json([
                'status' => false,
                'message' => 'Book id is required!',
            ], 400);

        }else{
            $book_id = $request->input('book_id');
            $book = Book::find($book_id);
            $book->increment('views');
            
             return response()->json([
                'status' => true,
                'message' => 'View count added successfully',
            ], 200);
            
        }
            
    }
    public function get_dashboard_data(Request $request)
    {
       
        if ($request->has('book_title')) {

           $book_title = $request->input('book_title');
           if($book_title == 'popularBooks'){

                $popular_data = HomeCategory::where('name', 'popular')->first();
                if($popular_data){
                    $popularbooks = Book::with('favorites')->where('status', 'active')->where('showbookto', 'all_users')->where('home_category', $popular_data->id)->orderBy('id','DESC')->take(10)->get();
                    
                        $a = array();
                        foreach ($popularbooks as $pbook) {
                    
                            foreach ($pbook->favorites as $fav) {
                
                                if($fav->user_id == auth::user()->user_id){ 
                                    array_push($a, $fav->book_id);
                                }
                                
                            }
                            unset($pbook->favorites);
                        }
                        
                  
                    
                    if(!$popularbooks){
                        return response()->json([
                            'status' => true,
                            'message' => 'No data found!',
                            'books' => null,
                        ], 200);
                    }else{
                        return response()->json([
                            'status' => true,
                            'message' => 'Success',
                            'books' => $popularbooks,
                            'favorite' => $a,
                        ], 200);
                    }

                }else{
                    return response()->json([
                        'status' => false,
                        'message' => 'No Popolar category available, please try again',
                    ], 401);
                }

            }else if($book_title == 'recommendedBooks'){

                $recommended_data = HomeCategory::where('name', 'recommended')->first();
                if($recommended_data){
                    $recommendedbooks = Book::with('favorites')->where('home_category', $recommended_data->id)->where('status', 'active')->where('showbookto', 'all_users')->orderBy('id','DESC')->take(10)->get();
                        
                        
                         $a = array();
                        foreach ($recommendedbooks as $pbook) {
                      
                            foreach ($pbook->favorites as $fav) {
                
                                if($fav->user_id == auth::user()->user_id){ 
                                    array_push($a, $fav->book_id);
                                }
                                
                            }
                            
                             unset($pbook->favorites);
                        }
                        
                    if(!$recommendedbooks){
                        return response()->json([
                            'status' => true,
                            'message' => 'No data found!',
                            'books' => null,
                        ], 200);
                    }else{
                        return response()->json([
                            'status' => true,
                            'message' => 'Success',
                            'books' => $recommendedbooks,
                            'favorite' => $a,
                        ], 200);
                    }

                }else{
                    return response()->json([
                        'status' => false,
                        'message' => 'No Recommended category available, please try again',
                    ], 401);
                }

           }else if($book_title == 'newReleaseBooks'){
                $newreleasebooks = Book::with('favorites')->where('status', 'active')->where('showbookto', 'all_users')->orderBy('id','DESC')->take(10)->get();
                    
                     $a = array();
                        foreach ($newreleasebooks as $pbook) {
                      
                            foreach ($pbook->favorites as $fav) {
                
                                if($fav->user_id == auth::user()->user_id){ 
                                    array_push($a, $fav->book_id);
                                }
                                
                            }
                            
                             unset($pbook->favorites);
                        }
                        
                if(!$newreleasebooks){
                    return response()->json([
                        'status' => true,
                        'message' => 'No data found!',
                        'books' => null,
                    ], 200);
                }else{
                    return response()->json([
                        'status' => true,
                        'message' => 'Success',
                        'books' => $newreleasebooks,
                        'favorite' => $a,
                    ], 200);
                }

            }else if($book_title == 'memberBooks'){

                   $membersbooks = Book::with('favorites')->where('status', 'active')->where('showbookto', 'paid_users')->orderBy('id','DESC')->take(10)->get();
                    
                    $a = array();
                        foreach ($membersbooks as $pbook) {
                      
                            foreach ($pbook->favorites as $fav) {
                
                                if($fav->user_id == auth::user()->user_id){ 
                                    array_push($a, $fav->book_id);
                                }
                                
                            }
                            
                             unset($pbook->favorites);
                        }
                        
                    if(!$membersbooks){
                        return response()->json([
                            'status' => true,
                            'message' => 'No data found!',
                            'books' => null,
                        ], 200);
                    }else{
                        return response()->json([
                            'status' => true,
                            'message' => 'Success',
                            'books' => $membersbooks,
                            'favorite' => $a,
                        ], 200);
                    }

           }else if($book_title == 'authors'){

                   $authors = Author::where('status', 'active')->orderBy('id','DESC')->take(4)->get();

                    if(!$authors){
                        return response()->json([
                            'status' => true,
                            'message' => 'No data found!',
                            'author' => null,
                        ], 200);
                    }else{
                        return response()->json([
                            'status' => true,
                            'message' => 'Success',
                            'authors' => $authors,
                        ], 200);
                    }
           }else{
                return response()->json([
                    'status' => false,
                    'message' => 'No Data available',
                ], 401);
           }

        

        }else{
        
           $ffbooks = Book::with('favorites')->where('status', 'active')->orderBy('id','DESC')->get();
        
         $a = array();
                        foreach ($ffbooks as $pbook) {
                      
                            foreach ($pbook->favorites as $fav) {
                
                                if($fav->user_id == auth::user()->user_id){ 
                                    array_push($a, $fav->book_id);
                                }
                                
                            }
                        }
                        
            $popular_data = HomeCategory::where('name', 'popular')->first();
            if($popular_data){
                $popularbooks = Book::where('status', 'active')->where('showbookto', 'all_users')->where('home_category', $popular_data->id)->orderBy('id','DESC')->take(4)->get();
                
                    
                        
                if(!$popularbooks){
                    return response()->json([
                        'status' => false,
                        'message' => 'No Popolar books available, please try again',
                    ], 401);
                }

            }else{
                return response()->json([
                    'status' => false,
                    'message' => 'No Popolar category available, please try again',
                ], 401);
            }

            $recommended_data = HomeCategory::where('name', 'recommended')->first();
            
            
            if($recommended_data){
                $recommendedbooks = Book::where('home_category', $recommended_data->id)->where('status', 'active')->where('showbookto', 'all_users')->orderBy('id','DESC')->take(4)->get();
                
                
                        
                if(!$recommendedbooks){
                    return response()->json([
                        'status' => false,
                        'message' => 'No Recommended books available, please try again',
                    ], 401);
                }

            }else{
                return response()->json([
                    'status' => false,
                    'message' => 'No Recommended category available, please try again',
                ], 401);
            }


            $newreleasebooks = Book::where('status', 'active')->where('showbookto', 'all_users')->orderBy('id','DESC')->take(4)->get();

              
                        
                        
            if(!$newreleasebooks){
                return response()->json([
                    'status' => false,
                    'message' => 'No new release books available, please try again',
                ], 401);
            }


            $membersbooks = Book::where('status', 'active')->where('showbookto', 'paid_users')->orderBy('id','DESC')->take(4)->get();
                
               
                        
                        
            if(!$membersbooks){
                return response()->json([
                    'status' => false,
                    'message' => 'No member books available, please try again',
                ], 401);
            }


            $authors = Author::where('status', 'active')->orderBy('id','DESC')->take(4)->get();

            if(!$authors){
                return response()->json([
                    'status' => false,
                    'message' => 'No author available, please try again',
                ], 401);
            }


            return response()->json([
                'status' => true,
                'message' => 'Get dashboard data successfully',
                'popularbooks' => $popularbooks,
                'recommendedbooks' => $recommendedbooks,
                'newreleasebooks' => $newreleasebooks,
                'membersbooks' => $membersbooks,
                'authors' => $authors,
                'favorite' => $a,
            ], 200);
        }
       
    }

    public function destroy_review(Request $request)
    {
         if ($request->has('review_id')) {
            $review_id = $request->input('review_id');
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Review id required, please try again',
            ], 401);
        }
        
        $delete = Review::findOrFail($review_id);

		if($delete->delete()){
			return response()->json([
                'status' => true,
                'message' => 'Deleted Successfully',
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Not deleted, please try again',
            ], 401);
        }
        
    
    }
    
    public function author_details_with_books_and_review(Request $request)
    {
        if ($request->has('author_id')) {
            $id = $request->input('author_id');
        }
        
        $author = Author::where('id', $id)->first();

        $follow = Follow::where('author_id', $id)->get();
        if($follow){
            $no_of_followers = count($follow);
        }else{
            $no_of_followers = 0;
        }
        
        $authorbooks = Book::where('status', 'active')->where('author_name', $author->name)->where('showbookto', 'all_users')->orderBy('id','DESC')->get();
        $ffbooks = Book::with('favorites')->where('status', 'active')->where('author_name', $author->name)->where('showbookto', 'all_users')->orderBy('id','DESC')->get();

        $a = array();
        foreach ($ffbooks as $pbook) {
      
            foreach ($pbook->favorites as $fav) {

                if($fav->user_id == auth::user()->user_id){ 
                    array_push($a, $fav->book_id);
                }
                
            }
        }
                
        if($authorbooks){
            $no_of_authorbooks = count($authorbooks);
        }else{
            $no_of_authorbooks = 0;
        }

        $rev = array();
        foreach($authorbooks as $book){
            $book_id = $book->id;
            $rev = Review::with('userdetails')->where('book_id', $book_id)->orderBy('id','DESC')->get();
            // array_push($rev, $reviews);
        }
        

        if($author){
            
            $authorf = Follow::where('author_id', $id)->where('user_id', auth::user()->user_id)->first();
            
            if($authorf){
                $is_follow = 1;
            }else{
                $is_follow = 0;
            }
            
            return response()->json([
                'status' => true,
                'message' => 'Success',
                'author' => $author,
                'no_of_followers' => $no_of_followers,
                'no_of_authorbooks' => $no_of_authorbooks,
                'is_follow' => $is_follow,
                'authorbooks' => $authorbooks,
                'authorbooksreviews' => $rev,
                 'favorite' => $a,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Author not exist, please try again',
            ], 401);
        }
       
    }

    public function book_details_with_review(Request $request)
    {
         if ($request->has('book_id')) {
            $book_id = $request->input('book_id');
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Book id required, please try again',
            ], 401);
        }
        
        $book = Book::where('id', $book_id)->first();
        
        if($book){
            // $book_id = $book->id;
            $reviews = Review::with('userdetails')->where('book_id', $book_id)->orderBy('id','DESC')->get();
            $rev_count = count($reviews);
            $review2 = Review::with('userdetails')->where('book_id', $book_id)->orderBy('id','DESC')->skip(0)->take(2)->get();
           
        }
        
        if($book){
            
            $fav = Favorite::where('book_id', $book_id)->where('user_id', auth::user()->user_id)->get();
      
            if(count($fav) > 0){  
                $isFavorite = 1;
            }else{
                $isFavorite = 0;
            }
            
            $bmk = Bookmark::where('book_id', $book_id)->where('user_id', auth::user()->user_id)->get();
      
            if(count($bmk) > 0){  
                $isBookmark = 1;
            }else{
                $isBookmark = 0;
            }
            
            
            $allfav = Favorite::where('book_id', $book_id)->get();
            $favcount = count($allfav);
            
            $allchapter = Chapter::where('book_id', $book_id)->get();
            $chaptercount = count($allchapter);
            
            return response()->json([
                'status' => true,
                'message' => 'Get book details successfully',
                'book' => $book,
                'reviews' => $review2,
                'rev_count' => $rev_count,
                'isFavorite' => $isFavorite,
                'isBookmark' => $isBookmark,
                'Favorite_count' => $favcount,
                'Chapter_count' => $chaptercount,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Book not exist, please try again',
            ], 401);
        }
       
    }
    
     public function book_details_all_reviews(Request $request)
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
        
        if ($request->has('book_id')) {
            $book_id = $request->input('book_id');
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Book id required, please try again',
            ], 401);
        }
            
        $book = Book::where('id', $book_id)->first();
        
        if($book){
            $book_id = $book->id;
            $reviews = Review::with('userdetails')->where('book_id', $book_id)->orderBy('id','DESC')->skip($offset)->take($limit)->get();
            
        }
        
        if($book){
            return response()->json([
                'status' => true,
                'message' => 'Get book reviews successfully',
                'reviews' => $reviews,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Book not exist, please try again',
            ], 401);
        }
       
    }

    public function similar_recomandation(Request $request)
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
             $exist = Genre::where('name', 'Any')->first();
            if($exist->id == $data['genre']){
                $data['genre'] = array();
            }else{
                $data['genre'] = $data['genre'];
            }
        }else{
            $data['genre'] = array();
        }
        
        if ($request->has('length')) {
             $data['length'] = $request->input('length');
             $exist = Length::where('name', 'Any')->first();
            if($exist->id == $data['length']){
                $data['length'] = array();
            }else{
                $data['length'] = $data['length'];
            }
        }else{
            $data['length'] = array();
        }
        
        if ($request->has('language')) {
             $data['language'] = $request->input('language');
             $exist = Language::where('name', 'Any')->first();
            if($exist->id == $data['language']){
                $data['language'] = array();
            }else{
                $data['language'] = $data['language'];
            }
        }else{
            $data['language'] = array();
        }
      
         if ($request->has('level')) {
             $data['level'] = $request->input('level');
             $exist = Level::where('name', 'Any')->first();
            if($exist->id == $data['level']){
                $data['level'] = array();
            }else{
                $data['level'] = $data['level'];
            }
        }else{
            $data['level'] = array();
        }
            
        // if ($request->has('genre')) {
        //     $data['genre'] = $request->input('genre'); 
        // }else{
        //     $data['genre'] = array();
        // }
        
        // if ($request->has('level')) {
        //     $data['level'] = $request->input('level'); 
        // }else{
        //     $data['level'] = array();
        // } 
        
        // if ($request->has('length')) {
        //     $data['length'] = $request->input('length'); 
        // }else{
        //     $data['length'] = array();
        // }
        
         if ($request->has('is_audio')) {
            $data['is_audio'] = $request->input('is_audio'); 
        }else{
            $data['is_audio'] = array();
        }
        
        // if ($request->has('language')) {
        //     $data['language'] = $request->input('language'); 
        // }else{
        //     $data['language'] = array();
        // }
    
           
        if ($request->has('in_book_details')) {
            $in_book_details = $request->input('in_book_details');
        }else{
            $in_book_details = 0;
        }
        
        if($in_book_details == 1){
            
            if ($request->has('category_id')) {
                $id = $request->input('category_id');
                $books = Book::where('status', 'active')
                ->where('category', $id)
                ->where('showbookto', 'all_users')
                ->when(!empty($data['genre']) , function ($query) use($data){
                    return $query->where('genre',$data['genre']);
                })
                ->when(!empty($data['level']) , function ($query) use($data){
                    return $query->where('level',$data['level']);
                })
                 ->when(!empty($data['length']) , function ($query) use($data){
                    return $query->where('length',$data['length']);
                })
                 ->when(!empty($data['language']) , function ($query) use($data){
                    return $query->where('language',$data['language']);
                })
                  ->when(!empty($data['is_audio']) , function ($query) use($data){
                    return $query->where('is_audio',$data['is_audio']);
                })
                ->orderBy('id','DESC')
                ->skip($offset)
                ->take(4)
                ->get();
                $ffbooks = Book::with('favorites')->where('status', 'active')->where('category', $id)->where('showbookto', 'all_users')->orderBy('id','DESC')->get();
    
            }else{
    
                $books = Book::where('status', 'active')
                ->where('showbookto', 'all_users')
                ->when(!empty($data['genre']) , function ($query) use($data){
                    return $query->where('genre',$data['genre']);
                })
                ->when(!empty($data['level']) , function ($query) use($data){
                    return $query->where('level',$data['level']);
                })
                 ->when(!empty($data['length']) , function ($query) use($data){
                    return $query->where('length',$data['length']);
                })
                 ->when(!empty($data['language']) , function ($query) use($data){
                    return $query->where('language',$data['language']);
                })
                  ->when(!empty($data['is_audio']) , function ($query) use($data){
                    return $query->where('is_audio',$data['is_audio']);
                })
                ->orderBy('id','DESC')
                ->skip($offset)
                ->take(4)
                ->get();
                $ffbooks = Book::with('favorites')->where('status', 'active')->where('showbookto', 'all_users')->orderBy('id','DESC')->get();
            }
        
        }else{
            
            if ($request->has('category_id')) {
                $id = $request->input('category_id');
                $books = Book::where('status', 'active')
                ->where('category', $id)
                ->where('showbookto', 'all_users')
                ->when(!empty($data['genre']) , function ($query) use($data){
                    return $query->where('genre',$data['genre']);
                })
                ->when(!empty($data['level']) , function ($query) use($data){
                    return $query->where('level',$data['level']);
                })
                   ->when(!empty($data['length']) , function ($query) use($data){
                    return $query->where('length',$data['length']);
                })
                 ->when(!empty($data['language']) , function ($query) use($data){
                    return $query->where('language',$data['language']);
                })
                 ->when(!empty($data['is_audio']) , function ($query) use($data){
                    return $query->where('is_audio',$data['is_audio']);
                })
                ->orderBy('id','DESC')
                ->skip($offset)
                ->take($limit)
                ->get();
                $ffbooks = Book::with('favorites')->where('status', 'active')->where('category', $id)->where('showbookto', 'all_users')->orderBy('id','DESC')->get();
    
            }else{
    
                $books = Book::where('status', 'active')
                ->where('showbookto', 'all_users')
                ->when(!empty($data['genre']) , function ($query) use($data){
                    return $query->where('genre',$data['genre']);
                })
                ->when(!empty($data['level']) , function ($query) use($data){
                    return $query->where('level',$data['level']);
                })
                  ->when(!empty($data['length']) , function ($query) use($data){
                    return $query->where('length',$data['length']);
                })
                 ->when(!empty($data['language']) , function ($query) use($data){
                    return $query->where('language',$data['language']);
                })
                 ->when(!empty($data['is_audio']) , function ($query) use($data){
                    return $query->where('is_audio',$data['is_audio']);
                })
                ->orderBy('id','DESC')
                ->skip($offset)
                ->take($limit)
                ->get();
                $ffbooks = Book::with('favorites')->where('status', 'active')->where('showbookto', 'all_users')->orderBy('id','DESC')->get();
            }
        
        }
        
        
        
        
        
        if($books){
            
            
            $a = array();
            foreach ($ffbooks as $pbook) {
          
                foreach ($pbook->favorites as $fav) {
    
                    if($fav->user_id == auth::user()->user_id){ 
                        array_push($a, $fav->book_id);
                    }
                    
                }
            }
            
            $genre = Genre::orderBy('id','DESC')->get();
            $length = Length::orderBy('id','DESC')->get();
            $language  = Language::orderBy('id','DESC')->get();
            $level= Level::orderBy('id','DESC')->get();
                
            return response()->json([
                'status' => true,
                'message' => 'Get books successfully',
                'books' => $books,
                'favorite' => $a,
                'genre' => $genre,
                'length' => $length,
                'language' => $language,
                'level' => $level,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Book not exist, please try again',
            ], 401);
        }
       
    }

    public function book_chapters_with_audio(Request $request)
    {
        
        if ($request->has('book_id')) {
            $book_id = $request->input('book_id');
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Book id required, please try again',
            ], 401);
        }
        
        $chapters = Chapter::where('book_id', $book_id)->get();
        
        
        if($chapters){
            
            $quizs = Quiz::where('book_id', $book_id)->get();
                
            if(count($quizs) > 0){
                $isQuiz = 1;
            }else{
                $isQuiz = 0;
            }
            
            $bmk = Bookmark::where('book_id', $book_id)->where('user_id', auth::user()->user_id)->get();
            
            $bmkid = Bookmark::where('book_id', $book_id)->where('user_id', auth::user()->user_id)->pluck('chapter_id')->toArray();
            
            if(count($bmk) > 0){  
                $isBookmark = 1;
            }else{
                $isBookmark = 0;
            }
            
            return response()->json([
                'status' => true,
                'message' => 'Get chapters successfully',
                'chapters' => $chapters,
                'isQuiz' => $isQuiz,
                'isBookmark' => $isBookmark,
                'Bookmark' => $bmkid,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Chapters not exist, please try again',
            ], 401);
        }
       
    }

    public function book_details_with_video(Request $request)
    {
        if ($request->has('book_id')) {
            $book_id = $request->input('book_id');
        }
        
        $book = Book::where('id', $book_id)->first();
        
        
        if($book){
            
            $fav = Favorite::where('book_id', $book_id)->where('user_id', auth::user()->user_id)->get();
      
            if(count($fav) > 0){  
                $isFavorite = 1;
            }else{
                $isFavorite = 0;
            }
            
            $bmk = Bookmark::where('book_id', $book_id)->where('user_id', auth::user()->user_id)->get();
      
            if(count($bmk) > 0){  
                $isBookmark = 1;
            }else{
                $isBookmark = 0;
            }
            
            return response()->json([
                'status' => true,
                'message' => 'Get book details successfully',
                'book' => $book,
                'isFavorite' => $isFavorite,
                'isBookmark' => $isBookmark,
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Book not exist, please try again',
            ], 401);
        }
       
    }

    public function add_view_book(Request $request)
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

            $book_id = $request->book_id;
            $user_id = auth::user()->user_id;

            $book = Book::where('id', $book_id)->first();

            $vbook = ViewBook::where('book_id', $book_id)->where('user_id', $user_id)->first();
            if($vbook){

                if($request->chapter){

                    if($request->chapter > $vbook->chapter){
                            $chapters = Chapter::where('book_id', $book_id)->get();
                            $no_chapters = count($chapters);  

                                $partialValue = $request->chapter;
                                $totalValue = $no_chapters;
                                $percentage = ($partialValue / $totalValue) * 100;

                            if($percentage == 100){
                                $status = 'finish';
                            }else{
                                $status = 'reading';
                            }
                            
                            $chapter = $request->chapter;
                            $read_type = 'reading';

                            $data = array(
                                'chapter' => $chapter,
                                'read_type' => $read_type,
                                'status' => $status,
                                'percentage' => $percentage,  
                                 
                            );
                                
                            ViewBook::where('id',$vbook->id)->update($data);

                            return response()->json([
                                'status' => true,
                                'message' => 'Success',
                                
                            ], 200);

                    }else{
                        $chapter = $request->chapter;
                        $read_type = 'reading';
                        
                        $data = array(
                            'chapter' => $chapter,
                            'read_type' => $read_type,
                        );
                            
                        ViewBook::where('id',$vbook->id)->update($data);

                        return response()->json([
                            'status' => true,
                            'message' => 'Success',
                            
                        ], 200);
                        // return response()->json([
                        //     'status' => true,
                        //     'message' => 'already added in view list',
                        // ], 200);
                    }

                }else if($request->video){
                      $read_type = 'watching'; 
                      $status = 'watching';
                      $video = $book->video; 

                        $data = array(
                           
                            'video' => $video,
                            'read_type' => $read_type,
                            'status' => $status,
                           
                        );
                            
                        ViewBook::where('id',$vbook->id)->update($data);

                        return response()->json([
                                'status' => true,
                                'message' => 'Success',
                              
                            ], 200);

                }else{

                        return response()->json([
                            'status' => false,
                            'message' => 'No book added in view list, please try again',
                        ], 401);
                }

                

            }else{

                if($request->chapter){
                    $chapters = Chapter::where('book_id', $book_id)->get();
                    $no_chapters = count($chapters);  

                        $partialValue = $request->chapter;
                        $totalValue = $no_chapters;
                        $percentage = ($partialValue / $totalValue) * 100;

                      $read_type = 'reading'; 
                      $status = 'reading';
                      $chapter = $request->chapter;

                     $viewBook = ViewBook::create([
                        'book_id' => $request->book_id,
                        'user_id' => $user_id,
                        'chapter' => $chapter,
                        'read_type' => $read_type,
                        'status' => $status,
                        'percentage' => $percentage, 
                    ]);

                     return response()->json([
                                'status' => true,
                                'message' => 'Success',
                                
                            ], 200);

                }else if($request->video){
                      $read_type = 'watching'; 
                      $status = 'watching';
                      $video = $book->video; 

                        $viewBook = ViewBook::create([
                            'book_id' => $request->book_id,
                            'user_id' => $user_id,
                            'video' => $video,
                            'read_type' => $read_type,
                            'status' => $status,
                           
                        ]);
                            return response()->json([
                                'status' => true,
                                'message' => 'Success',
                                
                            ], 200);

                }else{
                        return response()->json([
                            'status' => false,
                            'message' => 'No book added in view list, please try again',
                        ], 401);
                     
                }
               
            }

        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }

    public function add_finish_book(Request $request)
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

            $book_id = $request->book_id;
            $user_id = auth::user()->user_id;

            $book = Book::where('id', $book_id)->first();

            $vbook = ViewBook::where('book_id', $book_id)->where('user_id', $user_id)->first();
            if($vbook){

                        $status = 'finish';
                      
                        $data = array(
                            'status' => $status,
                        );
                            
                        ViewBook::where('id',$vbook->id)->update($data);

                        return response()->json([
                                'status' => true,
                                'message' => 'Success', 
                            ], 200);

                
            }else{

               
                        return response()->json([
                            'status' => false,
                            'message' => 'Book does not exist!',
                        ], 400);
                     
                
               
            }

        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }

    public function get_any_view_book_status(Request $request)
    {
        try {

            $validateUser = Validator::make($request->all(), 
            [
                'user_id' => 'required',
                'book_id' => 'required',
               
            ]);

            if($validateUser->fails()){
                return response()->json([
                    'status' => false,
                    'message' => 'validation error',
                    'errors' => $validateUser->errors()
                ], 401);
            }

            $book_id = $request->book_id;
            $user_id = $request->user_id;

            $vbook = ViewBook::with('bookdetails')->where('book_id', $book_id)->where('user_id', $user_id)->first();
            if($vbook){

                        return response()->json([
                                'status' => true,
                                'message' => 'got view book status successfully', 
                                'books' => $vbook
                            ], 200);
                
            }else{
                        return response()->json([
                            'status' => false,
                            'message' => 'No book available, please try again',
                        ], 401);
                   
            }

        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }

    public function get_continue_book_status()
    {
        
            $user_id = Auth::user()->user_id;

            $vbook = ViewBook::with('bookdetails')->where('user_id', $user_id)->orderBy('updated_at','DESC')->first();
            if($vbook){
                        $ffbooks = Book::with('favorites')->where('status', 'active')->where('showbookto', 'all_users')->orderBy('id','DESC')->get();

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
                                'message' => 'got view book status successfully', 
                                'book' => $vbook,
                                'favorite' => $a,
                            ], 200);
                
            }else{
                        return response()->json([
                            'status' => false,
                            'message' => 'No book available, please try again',
                        ], 200);
                   
            }

        
    }
    public function get_all_view_books(Request $request)
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
            
           $user_id = Auth::user()->user_id;

            $vbook = ViewBook::with('bookdetails')->where('user_id', $user_id)->orderBy('id','DESC')->skip($offset)->take($limit)->get();
            if($vbook){
                        
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
                                'message' => 'get all view book successfully', 
                                'books' => $vbook,
                                'favorite' => $a,
                            ], 200);
                
            }else{
                        return response()->json([
                            'status' => false,
                            'message' => 'No book available, please try again',
                        ], 401);
                   
            }

        
    }

    public function get_finish_books(Request $request)
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
        
           $user_id = Auth::user()->user_id;

            $vbook = ViewBook::with('bookdetails')->where('user_id', $user_id)->where('status', 'finish')->orderBy('id','DESC')->skip($offset)->take($limit)->get();
            if($vbook){
                
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
                                'message' => 'Success', 
                                'books' => $vbook,
                                'favorite' => $a,
                            ], 200);
                
            }else{
                        return response()->json([
                            'status' => false,
                            'message' => 'No data found!',
                            'books' => [],
                        ], 401);
                   
            }

        
    }

    public function searchby_bookname($bookname)
    {

            $books = Book::where('title', 'LIKE', '%' . $bookname . '%')->where('status', 'active')->orderBy('id','DESC')->get();
            if($books){

                        return response()->json([
                                'status' => true,
                                'message' => 'get books successfully', 
                                'books' => $books
                            ], 200);
                
            }else{
                        return response()->json([
                            'status' => false,
                            'message' => 'No book available, please try again',
                        ], 401);
                   
            }

        
    }

    public function get_category()
    {
            $categories = Category::where('status', 'active')->orderBy('id','DESC')->get();
            if($categories){

                        return response()->json([
                                'status' => true,
                                'message' => 'get categories successfully', 
                                'category' => $categories
                            ], 200);
                
            }else{
                        return response()->json([
                            'status' => false,
                            'message' => 'No category available, please try again',
                        ], 401);
                   
            }  
    }

    public function get_english_accent()
    {
            $english_accent = EnglishAccent::orderBy('id','DESC')->get();
            if($english_accent){

                        return response()->json([
                                'status' => true,
                                'message' => 'get english accent successfully', 
                                'englishaccent' => $english_accent
                            ], 200);
                
            }else{
                        return response()->json([
                            'status' => false,
                            'message' => 'No english accent available, please try again',
                        ], 401);
                   
            }  
    }

    public function get_level()
    {
            $level = Level::orderBy('id','DESC')->get();
            if($level){

                        return response()->json([
                                'status' => true,
                                'message' => 'get level successfully', 
                                'level' => $level
                            ], 200);
                
            }else{
                        return response()->json([
                            'status' => false,
                            'message' => 'No level available, please try again',
                        ], 401);
                   
            }  
    }
    
    public function get_length()
    {
            $length = Length::orderBy('id','DESC')->get();
            if($length){

                        return response()->json([
                                'status' => true,
                                'message' => 'get length successfully', 
                                'length' => $length
                            ], 200);
                
            }else{
                        return response()->json([
                            'status' => false,
                            'message' => 'No length available, please try again',
                        ], 401);
                   
            }  
    }
    
    public function get_language()
    {
            $language = Language::orderBy('id','DESC')->get();
            if($language){

                        return response()->json([
                                'status' => true,
                                'message' => 'get language successfully', 
                                'language' => $language
                            ], 200);
                
            }else{
                        return response()->json([
                            'status' => false,
                            'message' => 'No language available, please try again',
                        ], 401);
                   
            }  
    }



    public function searchby_filter(Request $request)
    { 
        
        // $query = array();
        // $category = $request->input('category') ?? []; 
        // $english_accent = $request->input('english_accent') ?? []; 
        // $level = $request->input('level') ?? []; 
       
        

        // $books = Book::query()
        // ->when($query, function ($queryBuilder) use ($query) {
        //     $queryBuilder->whereIn('category', $category);
        // })
        // ->when($query, function ($queryBuilder) use ($query) {
        //     $queryBuilder->whereIn('english_accent', $english_accent);
        // })
        // ->when($query, function ($queryBuilder) use ($query) {
        //     $queryBuilder->whereIn('level', $level);
        // })
        // ->get();

        // $data = $request->all();
          // $data = $request->all();
        // $category = explode(',', $request->input('category'));
        //     $data['category'] = $category; 
            
        //     print_r($data['category']); die;
        
        
        // if ($request->has('book_name')) {
        //     $bookname = $request->input('book_name'); 
            
        //     $books = Book::where('title', 'LIKE', '%' . $bookname . '%')->where('status', 'active')->orderBy('id','DESC')->get();
        //     $ffbooks = Book::with('favorites')->where('title', 'LIKE', '%' . $bookname . '%')->where('status', 'active')->orderBy('id','DESC')->get();

        //         $a = array();
        //         foreach ($ffbooks as $pbook) {
              
        //             foreach ($pbook->favorites as $fav) {
        
        //                 if($fav->user_id == auth::user()->user_id){ 
        //                     array_push($a, $fav->book_id);
        //                 }
                        
        //             }
        //         }
                
        //     if($books){

        //                 return response()->json([
        //                         'status' => true,
        //                         'message' => 'get books successfully', 
        //                         'books' => $books,
        //                         'favorite' => $a
        //                     ], 200);
                
        //     }else{
        //                 return response()->json([
        //                     'status' => false,
        //                     'message' => 'No book available, please try again',
        //                 ], 401);
                   
        //     }
            
        // }
        
         
            
        if ($request->has('book_name')) {
            if(!empty($request->input('book_name'))){
                $data['book_name']  = $request->input('book_name');
            }else{
                $data['book_name'] = '';
            }
            
        }else{
             $data['book_name'] = '';
        }    
            
        if ($request->has('category')) {
            if(!empty($request->input('category'))){
                $integer_category = array_map('intval', explode(',', $request->input('category')));
                $data['category'] = $integer_category; 
            }else{
                $data['category'] = array();
            }
            
        }else{
            $data['category'] = array();
        }
      
        if ($request->has('english_accent')) {
            // if(!empty($request->input('english_accent'))){
            //     $integer_english_accent = array_map('intval', explode(',', $request->input('english_accent')));
            // $data['english_accent'] = $integer_english_accent; 
            // }else{
            //     $data['english_accent'] = array();
            // }
            
            // $data['english_accent'] = $request->input('english_accent');
            //  $exist = EnglishAccent::where('name', 'Any')->first();
            // if($exist->id == $data['english_accent']){
            //     $data['english_accent'] = array();
            // }else{
            //     $data['english_accent'] = $data['english_accent'];
            // }
            
             $data['english_accent'] = $request->input('english_accent'); 
             $exist = EnglishAccent::where('name', 'Any')->first();
            if($exist->id == $data['english_accent']){ 
                $data['english_accent'] = array();
            }else{
                // $data['level'] = $data['level'];
                $integer_level = array_map('intval', explode(',', $request->input('english_accent')));
                $data['english_accent'] = $integer_level; 
            }
             
        }else{
            $data['english_accent'] = array();
        }
        
        if ($request->has('level')) {
            $data['level'] = $request->input('level'); 
             $exist = Level::where('name', 'Any')->first();
            if($exist->id == $data['level']){ 
                $data['level'] = array();
            }else{
                // $data['level'] = $data['level'];
                $integer_level = array_map('intval', explode(',', $request->input('level')));
                $data['level'] = $integer_level; 
            }
            // if(!empty($request->input('level'))){
            //     $integer_level = array_map('intval', explode(',', $request->input('level')));
            //     $data['level'] = $integer_level; 
            // }else{
            //     $data['level'] = array();
            // }
        }else{
            $data['level'] = array();
        }
        
        if ($request->has('genre')) {
            $data['genre'] = $request->input('genre'); 
             $exist = Genre::where('name', 'Any')->first();
            if($exist->id == $data['genre']){ 
                $data['genre'] = array();
            }else{
              
                $integer_level = array_map('intval', explode(',', $request->input('genre')));
                $data['genre'] = $integer_level; 
            }
           
        }else{
            $data['genre'] = array();
        }
        
         if ($request->has('length')) {
             
             $data['length'] = $request->input('length');
             $exist = Length::where('name', 'Any')->first();
            if($exist->id == $data['length']){
                $data['length'] = array();
            }else{
                // $data['length'] = $data['length'];
                $integer_length = array_map('intval', explode(',', $request->input('length'))); 
                $data['length'] = $integer_length; 
            }
            // if(!empty($request->input('length'))){
            //     $integer_length = array_map('intval', explode(',', $request->input('length'))); 
            //     $data['length'] = $integer_length; 
            // }else{
            //     $data['length'] = array();
            // }
        }else{
            $data['length'] = array();
        }
        
       
         if ($request->has('language')) {
                $data['language'] = $request->input('language');
                $exist = Language::where('name', 'Any')->first();
                if($exist->id == $data['language']){
                    $data['language'] = array();
                }else{
                    // $data['language'] = $data['language'];
                    $integer_language = array_map('intval', explode(',', $request->input('language')));
                    $data['language'] = $integer_language; 
                }
                
            // if(!empty($request->input('language'))){
            //     $integer_language = array_map('intval', explode(',', $request->input('language')));
            //     $data['language'] = $integer_language; 
            // }else{
            //     $data['language'] = array();
            // }
        }else{
            $data['language'] = array();
        }
        
        if ($request->has('what_you_want')) {
            if(!empty($request->input('what_you_want'))){
                $integer_what_you_want = array_map('intval', explode(',', $request->input('what_you_want')));
                $data['what_you_want'] = $integer_what_you_want; 
                if($data['what_you_want']){
                    if (in_array("video", $data['what_you_want'])){
                        $data['video'] = 'video';
                    }
                } 
            }else{
                $data['what_you_want'] = array();
            }
            
        }else{
            $data['what_you_want'] = array();
        }
            
        // $data['category'] = $request->input('category'); 
        // $data['english_accent'] = $request->input('english_accent'); 
        // $data['level'] = $request->input('level');   
        // $what_you_want = $request->input('what_you_want'); 
        // if($what_you_want){
        //     if (in_array("video", $what_you_want)){
        //         $data['video'] = 'video';
        //     }
        // }    
        
        
        
        if ($request->has('is_audio')) {
            $data['is_audio'] = $request->input('is_audio'); 
        }else{
            $data['is_audio'] = array();
        }
 

        $books =  Book::
        when(!empty($data['category']) , function ($query) use($data){
        return $query->whereIn('category',$data['category']);
        })
        ->when(!empty($data['english_accent']) , function ($query) use($data){
        return $query->whereIn('english_accent',$data['english_accent']);
        })
        ->when(!empty($data['level']) , function ($query) use($data){
        return $query->whereIn('level',$data['level']);
        })
        ->when(!empty($data['genre']) , function ($query) use($data){
        return $query->whereIn('genre',$data['genre']);
        })
        ->when(!empty($data['length']) , function ($query) use($data){
        return $query->whereIn('length',$data['length']);
        })
        ->when(!empty($data['language']) , function ($query) use($data){
        return $query->whereIn('language',$data['language']);
        })
        ->when(!empty($data['video']) , function ($query) use($data){
        return $query->whereNotNull('video');
        })
         ->when(!empty($data['book_name']) , function ($query) use($data){
        return $query->where('title', 'LIKE', '%' . $data['book_name'] . '%');
        })
         ->when(!empty($data['is_audio']) , function ($query) use($data){
        return $query->where('is_audio', $data['is_audio']);
        })
        ->get();
        
        
        $ffbooks = Book::with('favorites')
        ->when(!empty($data['category']) , function ($query) use($data){
        return $query->whereIn('category',$data['category']);
        })
        ->when(!empty($data['english_accent']) , function ($query) use($data){
        return $query->whereIn('english_accent',$data['english_accent']);
        })
        ->when(!empty($data['level']) , function ($query) use($data){
        return $query->whereIn('level',$data['level']);
        })
        ->when(!empty($data['genre']) , function ($query) use($data){
        return $query->whereIn('genre',$data['genre']);
        })
        ->when(!empty($data['length']) , function ($query) use($data){
        return $query->whereIn('length',$data['length']);
        })
        ->when(!empty($data['language']) , function ($query) use($data){
        return $query->whereIn('language',$data['language']);
        })
        ->when(!empty($data['video']) , function ($query) use($data){
        return $query->whereNotNull('video');
        })
         ->when(!empty($data['is_audio']) , function ($query) use($data){
        return $query->where('is_audio', $data['is_audio']);
        })
        ->get();

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
                                'message' => 'get books successfully', 
                                'books' => $books,
                                'favorite' => $a
                            ], 200);

        
    }
        
        
}
