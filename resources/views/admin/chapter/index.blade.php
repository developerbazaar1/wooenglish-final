@extends('admin.layouts.header')

@section('content')

<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-file"></i> Add chapters</h1>
        </div>
    </div>
    @if($message = Session::get('success_add'))
         <div class="alert alert-success alert-dismissible fade show w-100" role="alert">
           <strong>Success!</strong> {{ $message }}
           <button type="button" class="close" data-dismiss="alert" aria-label="Close" >
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
     @endif
     
    <section class="Addchapterform">
            <div class="tile">
                <div class="tile-body">
                    <div class=" cst-add-new-form row">
                        <!-- <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12">
                            <img class="w-100" src="{{ URL::asset('assets/images/categoryanimie-min.gif') }}">
                        </div> -->
                        <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12">
                            <form class="Add-chapter-form w-auto mt-5" method="POST" action="{{route('chapter-store')}}" enctype="multipart/form-data">
                              @csrf
                              <div class="form-group">
                                  <label class="form-head">Chapter No</label>
                                  <input class="form-control  @error('chapter_no') is-invalid @enderror" name="chapter_no" id="chapter_no" min="0" type="number"  placeholder="Enter chapter no">
                                  
                                  @error('chapter_no')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                              </div>
                              <div class="form-group">
                                  <label class="form-head">Chapter title</label>
                                  <input class="form-control  @error('chapter_name') is-invalid @enderror" name="chapter_name" id="chapter_name" type="text"  placeholder="Enter chapter title">
                                  
                                  @error('chapter_name')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                              </div>
                              <div class="form-group">
                                  <label class="form-head">Chapter Description</label>
                                  <textarea id="myTextarea" class="@error('content') is-invalid @enderror" name="content" ></textarea>
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
                            <input class="form-control  @error('audio_title') is-invalid @enderror" name="audio_title" id="audio_title" type="text" value="{{ old('audio_title') }}"  placeholder="Enter audio Title">
                              
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
                            
                              
                              <div class="form-group">
                                <input type="hidden" name="bookid" value="{{$id}}">
                                <button type="submit" class="btn btn-info w-100" id="demoNotify">Submit chapter</button>
                              </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
    </section>
   
   <section class="viewchapter">
      <div class="row">
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

         <div class="col-md-12">
            <div class="tile">
               <div class="tile-body">
                  <div class="table-responsive">
                     <table class="table table-hover table-bordered" id="sampleTable">
                        <thead>
                           <tr>
                              <th>Chapter.No</th>
                              <th>Chapter title</th>
                              <th>Audio Title</th>
                              <th>Audio</th>
                              <th>Action</th>
                           </tr>
                        </thead>
                        <tbody>
                         @if(count($chapters) > 0)
                           
                           @foreach($chapters as $chapter)
                           <tr>
                              <td>{{$chapter->chapter_no}}</td>
                              <td id="cat_name<?=$chapter->id?>">{{$chapter->chapter_name}}</td>
                              <td>{{$chapter->audio_title}}</td>
                              <td>
                                  @if(!empty($chapter->audio))
                                <audio controls autoplay>
                                    <source src="{{ URL::asset('/public/'.$chapter->audio) }}" type="audio/ogg">
                                    <source src="{{ URL::asset('/public/'.$chapter->audio) }}" type="audio/mpeg">
                                </audio>
                                @else
                                 No Audio Available
                                @endif
                              
                            </td>
                             
                              
                              <td class="">
                                  @php  $chid = Crypt::encrypt($chapter->id);  @endphp
                                <span>
                                  <a href="{{route('chapter-edit', $chid)}}" class="delet-btn px-3">
                                    <i class=" fa fa-pencil-square-o" aria-hidden="true"></i>
                                  </a>
                                </span>
                                <span>
                                  <a href="#" class="delet-btn demoSwal" id="demoSwal" data-id="{{$chapter->id}}" data-uri="delete-chapter">
                                    <i class=" fa fa-trash-o dlt-icon" aria-hidden="true"></i>
                                 </a>
                                </span>
                              </td>
                           </tr>
                          @endforeach
                         @endif
                           
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </section>
</main>
<!-- main content end  -->

 
@endsection
@section('scripts') 
<script src="{{ URL::asset('assets/js/plugins/pace.min.js') }}"></script>
<script type="text/javascript" src="{{ URL::asset('assets/js/plugins/jquery.dataTables.min.js') }}"></script>
<script type="text/javascript" src="{{ URL::asset('assets/js/plugins/dataTables.bootstrap.min.js') }}"></script>
<script type="text/javascript" src="{{ URL::asset('assets/js/plugins/sweetalert.min.js') }}"></script>
<script src="https://cdn.tiny.cloud/1/l0xp8n0asjxeoofeo9h30icll510jblob20r38r92ecoyw00/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
<script>
  tinymce.init({
    selector: 'textarea#myTextarea'
  });
</script>
<script type="text/javascript">
  $('#sampleTable').DataTable();
  
   $("#sampleTable").on("click", ".demoSwal", function(){

    var id = jQuery(this).attr('data-id');
    var uri = jQuery(this).attr('data-uri');
 var APP_URL = {!! json_encode(url('/')) !!}
    swal({
      title: "Are you sure?",
      text: "You will not be able to recover this data!",
      type: "warning",
      showCancelButton: true,
      confirmButtonText: "Yes, delete it!",
      cancelButtonText: "No, cancel plx!",
      closeOnConfirm: false,
      closeOnCancel: false
    }, function(isConfirm) {
      if (isConfirm) {
        swal("Deleted!", "Your data has been deleted.", "success");
        window.location.href=APP_URL+"/"+uri+"/"+id;
      } else {
        swal("Cancelled", "Your data is safe :)", "error");
      }
    });
  });
  
</script>
<script type="text/javascript" src="{{ URL::asset('assets/js/plugins/wooenglish_assets_js_dropify.min.js') }}"></script>
<script type="text/javascript">

  $('.dropify').dropify();
</script>
@endsection
