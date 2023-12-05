@extends('admin.layouts.header')

@section('content')

<main class="app-content">
    <div class="app-title">
            <div>
                <h1><i class="fa fa-file-audio-o"></i> Add Book Audio</h1>
            </div>
            <ul class="app-breadcrumb breadcrumb">
              <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
              @php  $bookid = Crypt::encrypt($bookid);  @endphp
              <li class="breadcrumb-item"><a href="{{ route('book-edit', $bookid) }}">Edit Books</a></li>
            </ul>
    </div>
    @if($message = Session::get('success_add'))
         <div class="alert alert-success alert-dismissible fade show w-100" role="alert">
           <strong>Success!</strong> {{ $message }}
           <button type="button" class="close" data-dismiss="alert" aria-label="Close" >
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
     @endif
     
    <section class="addaudioform">
        <div class="tile">
            <div class="tile-body">
                <div class=" cst-add-new-form row">
                    <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12 text-center">
                        <img class="w-100" src="{{ URL::asset('assets/images/Audiopage-img.jpg') }}">
                    </div>
                    <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12">
                        <form class="w-100" method="POST" action="{{route('audio-store')}}" enctype="multipart/form-data">
                          @csrf
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
                                <input type="hidden" name="bookid" value="{{$audio->id}}">
                                <input type="hidden" name="document_old" value="{{$audio->audio}}">
                                <div class="form-group">
                                  <button type="submit" class="btn btn-info w-100" id="demoNotify">Submit audio</button>
                                </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
   
   <section class="viewaudio">
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
                                <th>S.No</th>
                                <th>Audio Tittle</th>
                                <th>Preview</th>
                                <th>Action</th>
                           </tr>
                        </thead>
                        <tbody>
                         @if($audio->audio)
                           @php
                                $sno = 1;
                           @endphp
                          
                           <tr>
                              <td>{{$sno}}</td>
                              <td>{{$audio->audio_title}}</td>
                              <td>
                                <audio controls autoplay>
                                    <source src="{{ URL::asset('/public/'.$audio->audio) }}" type="audio/ogg">
                                    <source src="{{ URL::asset('/public/'.$audio->audio) }}" type="audio/mpeg">
                                </audio>
                              
                            </td>
                              <td class="">
                                 <a href="#" class="delet-btn demoSwal" id="demoSwal" data-id="{{$audio->id}}" data-uri="delete-audio">
                                    <i class=" fa fa-trash-o dlt-icon" aria-hidden="true"></i>
                                 </a>
                              </td>
                           </tr>
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
<script type="text/javascript" src="{{ URL::asset('assets/js/plugins/wooenglish_assets_js_dropify.min.js') }}"></script>
<script type="text/javascript">

  $('.dropify').dropify();
  
  $('#sampleTable').DataTable();
  
   $('.demoSwal').click(function(){

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

@endsection
