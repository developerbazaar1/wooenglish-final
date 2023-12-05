@extends('admin.layouts.header')

@section('content')

<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa-sharp fa-solid fa-circle-exclamation"></i> Add Third Party Master Data</h1>
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
    <section class="Addthirdpartyform">
            <div class="tile">
                <div class="tile-body">
                    <div class=" cst-add-new-form row">
                        <!--<div class="col-lg-6 col-sm-6 col-md-6 col-xs-12 text-center">-->
                        <!--    <img class="master-image  w-66px" src="{{ URL::asset('assets/images/master-cat-img.png') }}">-->
                        <!--</div>-->
                        <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12 mx-auto">
                            <form class="third-party-data w-100" method="POST" action="{{route('thirdparty-store')}}">
                              @csrf
                              <div class="form-group">
                                  <label class="form-head">Enter Facebook Url</label>
                                  <input class="form-control  @error('facebook_url') is-invalid @enderror" name="facebook_url" value="{{ old('facebook_url') }}" id="facebook_url" type="text"  placeholder="Enter Facebook Url">
                                  
                                  @error('facebook_url')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                              </div>
                              <div class="form-group">
                                  <label class="form-head">Enter Youtube Url</label>
                                  <input class="form-control  @error('youtube_url') is-invalid @enderror" name="youtube_url" value="{{ old('youtube_url') }}" id="youtube_url" type="text"  placeholder="Enter Youtube Url">
                                  
                                  @error('youtube_url')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                              </div>
                              <div class="form-group">
                                  <label class="form-head">Enter Mob Id</label>
                                  <input class="form-control  @error('mob_id') is-invalid @enderror" name="mob_id" id="mob_id" value="{{ old('mob_id') }}" type="text"  placeholder="Enter Mobile Id">
                                  
                                  @error('mob_id')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                              </div>
                              <div class="form-group">
                                  <label class="form-head">Enter PayPal Id</label>
                                  <input class="form-control  @error('paypal_id') is-invalid @enderror" name="paypal_id" value="{{ old('paypal_id') }}" id="paypal_id" type="text"  placeholder="Enter Paypal Id">
                                  
                                  @error('paypal_id')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                              </div>
                              <div class="form-group">
                                <button type="submit" class="btn btn-info w-100" id="demoNotify">Submit</button>
                              </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
    </section>
   
   <section class="viewthirdparty">
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
                             <th>Sr.No</th>
                             <th>Facebook Url</th>
                             <th>Youtube Url</th>
                             <th>Mob Id</th>
                             <th>PayPal Id</th>
                             <th>Delete</th>
                           </tr>
                        </thead>
                        <tbody>
                         @if($thirdparty) 
                           @php
                                $sno = 1; 
                           @endphp
                           <tr>
                              <td>{{$sno}}</td>
                              <td><a href="#" class="third-fb-data text-blue-underline">{{$thirdparty->facebook_url}}</a></td>
                              <td><a href="#" class="third-fb-data text-blue-underline">{{$thirdparty->youtube_url}}</a></td>
                              <td>{{$thirdparty->mob_id}}</td>
                              <td>{{$thirdparty->paypal_id}}</td>
                              <td class="">
                                 <a href="#" class="delet-btn demoSwal" id="demoSwal" data-id="{{$thirdparty->id}}" data-uri="delete-thirdparty">
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

@endsection
