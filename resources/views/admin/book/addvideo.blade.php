@extends('admin.layouts.header')

@section('content')

<main class="app-content">
   <div class="app-title">
        <div>
            <h1><i class="fa fa-file-video-o"></i> Add Book Video</h1>
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
                        <img class="v-upload-element w-50" src="{{ URL::asset('assets/images/video-pageimg.jpg') }}">
                    </div>
                    <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12">
                        <form class="Add-video-form w-auto" method="POST" action="{{route('video-store')}}">
                          @csrf
                            <div class="form-group">
                                <label class="form-head" for="exampletext">
                                    Video Tittle
                                </label>
                                <input class="form-control  @error('video_title') is-invalid @enderror" name="video_title" value="{{ old('video_title') }}" id="video_title" type="text"  placeholder="Enter video Title">
                              
                                  @error('video_title')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                            </div>
                            
                            
                            <!--for upload link-->
                            <div clas="form-group w-100">
                                    <label class="form-head" for="examplelink">Enter Video Link</label>
                                    <input class="form-control  @error('video') is-invalid @enderror" name="video" value="{{ old('video') }}" id="video" type="text"  placeholder="Enter video url">
                              
                                      @error('video')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                      @enderror
                            </div>
                            <input type="hidden" name="bookid" value="{{$video->id}}">
                            <div class="form-group mt-3">
                                <button type="submit" class="btn btn-info w-100" id="demoNotify">Submit video</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
   
   <section class="viewvideo">
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
                                <th>Tittle</th>
                                <th>Preview</th>
                                <th>Action</th>
                           </tr>
                        </thead>
                        <tbody>
                         @if($video->video)
                           @php
                                $sno = 1;
                           @endphp
                          
                           <tr>
                              <td>{{$sno}}</td>
                              <td>{{$video->video_title}}</td>
                              <td><a href="{{$video->video}}" target="_blank" class="video-prev-url">{{$video->video}}</a></td>
                              <td class="">
                                 <a href="#" class="delet-btn demoSwal" id="demoSwal" data-id="{{$video->id}}" data-uri="delete-video">
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
<script type="text/javascript">
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
