<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Book;
use App\Models\Category;
use App\Models\Author;
use App\Models\Language;
use App\Models\Length;
use App\Models\EnglishFluency;
use App\Models\EnglishAccent;
use App\Models\Genre;
use App\Models\Level;
use App\Models\HomeCategory;
use Illuminate\Support\Facades\Crypt;

class BookController extends Controller
{
   
    public function index()
    {   
        $books = Book::orderBy('id','DESC')->get();
        return view('admin.book.index',compact('books'));
    }

    
    public function create()
    {
        $english_fluencys = EnglishFluency::orderBy('id','ASC')->get();
        $languages = Language::orderBy('id','ASC')->get();
        $lengths = Length::orderBy('id','ASC')->get();
        $english_accents = EnglishAccent::orderBy('id','ASC')->get();
        $home_categories = HomeCategory::orderBy('id','ASC')->get();
        $genres = Genre::orderBy('id','ASC')->get();
        $levels = Level::orderBy('id','ASC')->get();
        $categories = Category::where('status', 'active')->orderBy('id','DESC')->get();
        $authors = Author::where('status', 'active')->orderBy('id','DESC')->get();
        return view('admin.book.create', compact('categories', 'authors', 'english_fluencys', 'english_accents', 'genres', 'levels', 'home_categories', 'languages', 'lengths'));
    }

    
    public function store(Request $request)
    { 

       // dd($request->all()); die;
        $validated = $request->validate([
          "title" => "required",
          "category" => "required",
          "author" => "required",
          "english_fluency" => "required",
          "english_accent" => "required",
          "language" => "required",
          "length" => "required",
          "total_words" => "required",
          "genre" => "required",
          "total_time" => "required",
          "level" => "required",
          "document" => "required",
          "content" => "required",
          "home_category" => "required",
          "showbookto" => "required",
          
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
                $image_path = public_path('upload/book');
                $request->document->move($image_path, $fileName);
                $formInput['document'] = 'upload/book/'.$fileName;
            }
            unset($formInput['document_old']);
        }else{
            $formInput['document'] = $request->input('document_old');
        }

        if($request->input('status') == 'on'){
            $status = 'active';
        }else{
            $status = 'inactive';
        }

        $data = array(
              "title" => $request->input('title'),
              "category" => $request->input('category'),
              "author_name" => $request->input('author'),
              "english_fluency" => $request->input('english_fluency'),
              "english_accent" => $request->input('english_accent'),
              "home_category" => $request->input('home_category'),
              "total_words" => $request->input('total_words'),
              "genre" => $request->input('genre'),
              "total_time" => $request->input('total_time'),
              "level" => $request->input('level'),
              "language" => $request->input('language'),
              "length" => $request->input('length'),
              "book_thumbnail" => $formInput['document'],
              "status" => $status,
              "book_description" => $request->input('content'),
              "showbookto" => $request->input('showbookto'),
              
        );
        
        $id = Book::create($data)->id;
        if($id){
            return redirect('books')->with('success',"Book Added Successfully!");
        }else{
            return redirect()->back()->with('error',"Book not added, please try again!");
        }
    
    
    }

    
    public function show($id)
    {
        //
    }

    
    public function destroy($id)
    {
        $delete = Book::findOrFail($id);
		$image1 = $delete->book_thumbnail;
		$image = "public/".$image1;
		if($delete->delete()){
			if(!empty($image)){
				if(file_exists($image)){
					unlink($image);
				}
			}
        }
        return redirect('books')->with('success','Book Deleted Successfully');
    
    }


    public function changebookStatus(Request $request)

    {
        $id = $request->book_id;
        $book = Book::find($id);

        if($request->status == '1'){
            $data = array(
                "status"=>'active', 
            );
        }else{
            $data = array(
                "status"=>'inactive', 
            );
        }            
          
        Book::where('id',$id)->update($data);

        return response()->json(['success'=>'Status change successfully.']);

    }

     public function edit($id)
    {
        $english_fluencys = EnglishFluency::orderBy('id','ASC')->get();
        $english_accents = EnglishAccent::orderBy('id','ASC')->get();
        $languages = Language::orderBy('id','ASC')->get();
        $lengths = Length::orderBy('id','ASC')->get();
        $home_categories = HomeCategory::orderBy('id','ASC')->get();
        $genres = Genre::orderBy('id','ASC')->get();
        $levels = Level::orderBy('id','ASC')->get();
        $categories = Category::where('status', 'active')->orderBy('id','DESC')->get();
        $authors = Author::where('status', 'active')->orderBy('id','DESC')->get();
        $bookid = Crypt::decrypt($id);
        $book = Book::where('id',$bookid)->first();
        return view('admin.book.edit', compact('book', 'categories', 'authors', 'english_fluencys', 'english_accents', 'genres', 'levels', 'home_categories', 'languages', 'lengths'));
    }

    public function update(Request $request)
    {
        $validated = $request->validate([
          "title" => "required",
          "category" => "required",
          "author" => "required",
          "english_fluency" => "required",
          "english_accent" => "required",
          "total_words" => "required",
          "genre" => "required",
          "language" => "required",
          "length" => "required",
          "total_time" => "required",
          "level" => "required",
          "content" => "required",
          "home_category" => "required",
          "showbookto" => "required",
          
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
                $image_path = public_path('upload/book');
                $request->document->move($image_path, $fileName);
                $formInput['document'] = 'upload/book/'.$fileName;
            }
            unset($formInput['document_old']);
        }else{
            $formInput['document'] = $request->input('document_old');
        }

        if($request->input('status') == 'on'){
            $status = 'active';
        }else{
            $status = 'inactive';
        }

        $data = array(
              "title" => $request->input('title'),
              "category" => $request->input('category'),
              "author_name" => $request->input('author'),
              "english_fluency" => $request->input('english_fluency'),
              "english_accent" => $request->input('english_accent'),
              "home_category" => $request->input('home_category'),
              "total_words" => $request->input('total_words'),
              "genre" => $request->input('genre'),
              "language" => $request->input('language'),
              "length" => $request->input('length'),
              "total_time" => $request->input('total_time'),
              "level" => $request->input('level'),
              "book_thumbnail" => $formInput['document'],
              "status" => $status,
              "book_description" => $request->input('content'),
              "showbookto" => $request->input('showbookto'),
        );
        
        
       
            $bookid = $request->input('bookid');
            Book::where('id',$bookid)->update($data);
           
            return redirect()->back()->with('success',"Book updated successfully!");
            
           
    }


     public function addvideo($id)
    {
        $bookid = Crypt::decrypt($id);
        $video = Book::where('id',$bookid)->first();
        return view('admin.book.addvideo', compact('video', 'bookid'));
    }

     public function addaudio($id)
    {
        $bookid = Crypt::decrypt($id);
        $audio = Book::where('id',$bookid)->first();
        return view('admin.book.addaudio', compact('audio', 'bookid'));
    }

    public function storevideo(Request $request)
    {
        $validated = $request->validate([
          "video_title" => "required",
          "video" => "required",
        ]);

        
        $data = array(
              "video_title" => $request->input('video_title'),
              "video" => $request->input('video'),  
        );
        
        
       
            $bookid = $request->input('bookid');
            Book::where('id',$bookid)->update($data);
           
            return redirect()->back()->with('success_add',"Video added successfully!");
            
           
    }

    public function storeaudio(Request $request)
    {
        $validated = $request->validate([
          "audio_title" => "required",
          "document" => "required",
         
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
                $image_path = public_path('upload/book');
                $request->document->move($image_path, $fileName);
                $formInput['document'] = 'upload/book/'.$fileName;
            }
            unset($formInput['document_old']);
        }else{
            $formInput['document'] = $request->input('document_old');
        }


        $data = array(
              "audio_title" => $request->input('audio_title'),
              "audio" => $formInput['document'],
        );
        
        $bookid = $request->input('bookid');
        Book::where('id',$bookid)->update($data);
       
        return redirect()->back()->with('success_add',"Audio added successfully!");
            
           
    }

    public function destroyvideo($id)
    {
        
        $data = array(
              "video_title" => "",
              "video" => "",  
        );
        
        
        Book::where('id',$id)->update($data);
       
        return redirect()->back()->with('success',"Video deleted successfully!");

    
    }

    public function destroyaudio($id)
    {
        
        $audio = Book::where('id',$id)->first();

        if(!empty($audio->audio)){
            if(file_exists(public_path('/').'/'.$audio->audio)){
                unlink(public_path('/').'/'.$audio->audio); 
            }
        }
        
        $data = array(
              "audio_title" => "",
              "audio" => "",
        );
        
        Book::where('id',$id)->update($data);
       
        return redirect()->back()->with('success',"Audio deleted successfully!");
            
           
    }

}

