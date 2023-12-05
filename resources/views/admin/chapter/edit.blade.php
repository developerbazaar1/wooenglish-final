@extends('admin.layouts.header')

@section('content')
    <main class="app-content">
        <div class="app-title">
            <div>
                <h1><i class="fa fa-chapter"></i> Edit chapter</h1>
            </div>
            <ul class="app-breadcrumb breadcrumb">
              <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
              @php  $bookid = Crypt::encrypt($chapter->book_id);  @endphp
              <li class="breadcrumb-item"><a href="{{ route('chapters', $bookid) }}">View Chapters</a></li>
            </ul>
        </div>

        
        <!-- inner section start -->

         @if($message = Session::get('success'))
             <div class="alert alert-success alert-dismissible fade show w-100" role="alert">
               <strong>Success!</strong> {{ $message }}
               <button type="button" class="close" data-dismiss="alert" aria-label="Close" >
                 <span aria-hidden="true">&times;</span>
               </button>
             </div>
         @endif

         @if($message = Session::get('error'))
              <div class="alert alert-danger alert-dismissible fade show w-100" role="alert">
               <strong>Error!</strong> {{ $message }}
               <button type="button" class="close" data-dismiss="alert" aria-label="Close" >
                 <span aria-hidden="true">&times;</span>
               </button>
             </div>
         @endif

        <section class="chapter-form">
            <!-- tile inner space -->
            <div class="tile">
                <div class="tile-body">
                    <div id="app_content" class="app-container">
                        <!-- add chapter form start-->
                        
                        <form class="w-100" id="addchapter-form" method="POST" action="{{route('chapter-update')}}" enctype="multipart/form-data">
                          @csrf
                           <div class="form-group">
                                  <label class="form-head">Chapter No</label>
                                  <input class="form-control  @error('chapter_no') is-invalid @enderror" name="chapter_no" id="chapter_no" min="0" type="number" value="@if(!empty($chapter->chapter_no)){{old('chapter_no', $chapter->chapter_no)}}@endif"  placeholder="Enter chapter no">
                                  
                                  @error('chapter_no')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                              </div>
                              <div class="form-group">
                                  <label class="form-head">Chapter title</label>
                                  <input class="form-control  @error('chapter_name') is-invalid @enderror" name="chapter_name" value="@if(!empty($chapter->chapter_name)){{old('chapter_name', $chapter->chapter_name)}}@endif" id="chapter_name" type="text"  placeholder="Enter chapter title">
                                  
                                  @error('chapter_name')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                              </div>
                              <div class="form-group">
                                  <label class="form-head">Chapter Description</label>
                                  <textarea id="myTextarea" class="@error('content') is-invalid @enderror" name="content" >@if(!empty($chapter->chapter_description)){{old('chapter_description', $chapter->chapter_description)}}@endif</textarea>
                                        @error('content')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                         @enderror
                              </div>
                              <div class="form-group">
                            <label class="form-head" for="exampletext">
                                Audio Name
                            </label>
                            <input class="form-control  @error('audio_title') is-invalid @enderror" name="audio_title" id="audio_title" type="text" value="@if(!empty($chapter->audio_title)){{old('audio_title', $chapter->audio_title)}}@endif"  placeholder="Enter audio Title">
                              
                                  @error('audio_title')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                        </div>
                        <div class="form-group">
                                <label class="form-head" for="exampletext">
                                   Select Audio File
                                </label>
                               <input name="document" type="file" class="dropify  @error('document') is-invalid @enderror" data-height="100" data-allowed-file-extensions="mp3" />
                               @error('document')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                               @enderror
                            </div>
                            @error('document')
                                <p style="color:#dc3545; font-size: 80%;" ><strong>{{ $message }}</strong></p>
                            @enderror
                            
                              
                              
                            <input type="hidden" name="document_old" value="{{$chapter->audio}}">  
                            <input type="hidden" name="chapterid" value="{{$chapter->id}}">
                            
                            <!-- :: submit button -->
                            <div class="form-group terms mt-2 mb-2">
                                <input type="submit" class="btn btn-info w-100" id=""></input>
                            </div>
                            <!-- :: end submit button -->
                        </form>
                        <!-- add chapter form up end -->
                    </div>
                </div>
            </div>
            <!-- tile inner space up end -->
        </section>
    </main>
   

@endsection
@section('scripts') 

<script src="https://cdn.tiny.cloud/1/l0xp8n0asjxeoofeo9h30icll510jblob20r38r92ecoyw00/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
<script>
  tinymce.init({
    selector: 'textarea#myTextarea'
  });
</script>

<!-- <script src="https://cdn.jsdelivr.net/npm/@tinymce/tinymce-webcomponent@2/dist/tinymce-webcomponent.min.js"></script> -->
<script src="{{ URL::asset('assets/js/plugins/jquery.dataTables.min.js') }}"></script>
<script src="{{ URL::asset('assets/js/plugins/dataTables.bootstrap.min.js') }}"></script>
<script src="{{ URL::asset('assets/js/plugins/wooenglish_assets_js_dropify.min.js') }}"></script>
<script src="{{ URL::asset('assets/js/plugins/pace.min.js') }}"></script>

<script type="text/javascript" src="{{ URL::asset('assets/js/plugins/wooenglish_assets_js_dropify.min.js') }}"></script>
<script type="text/javascript">

  $('.dropify').dropify();
</script>
@endsection