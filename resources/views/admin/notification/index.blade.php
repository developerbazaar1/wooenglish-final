@extends('admin.layouts.header')

@section('content')

<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-bell mx-2"></i>Notification</h1>
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
     
    <section class="Addnotificationform">
            <div class="tile">
                <div class="tile-body">
                    <div class=" cst-add-new-form row">
                        <!-- <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12">
                            <img class="w-100" src="{{ URL::asset('assets/images/terms-notification.jpg') }}">
                        </div> -->
                        <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12">
                            <form class="Add-notification-form w-auto " method="POST" action="{{route('notification-store')}}">
                              @csrf
                              
                              <div class="form-group">
                                  <label class="form-head">Notification Title</label>
                                  <input class="form-control  @error('notification_name') is-invalid @enderror" name="notification_name" value="{{ old('notification_name') }}" id="notification_name" type="text"  placeholder="Enter Notification Title">
                                  
                                  @error('notification_name')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                              </div>
                              <div class="form-group">
                                  <label class="form-head">Notification Description</label>
                                 <textarea class="@error('content') is-invalid @enderror form-control" placeholder="Description" id="exampleTextarea" rows="5" name="content" >{{ old('content') }}</textarea>
                                        @error('content')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                         @enderror
                              </div>
                               
                              <div class="form-group text-center">
                                <button type="submit"  class="btn btn-info mt-2 w-50" id=""><i
                                            class="fa-solid fa-paper-plane mx-2"></i>Submit</button>
                              </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
    </section>
   
   <section class="viewnotification">
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
                              <th>Notification Title</th>
                              <th>Notification Discription</th>
                              <th>Delete</th>
                           </tr>
                        </thead>
                        <tbody>
                         @if(count($notifications) > 0)
                           @php
                                $sno = 1;
                           @endphp
                           @foreach($notifications as $notification)
                           <tr>
                             @php  $notificationid = Crypt::encrypt($notification->id);  @endphp
                              <td>{{$sno}}</td>
                              <td>{{$notification->notification_name}}</td>
                              <td>{{$notification->notification_description}}</td>
                              
                              <td class="">
                                 <a href="#" class="delet-btn demoSwal" id="demoSwal" data-id="{{$notification->id}}" data-uri="delete-notification">
                                    <i class=" fa fa-trash-o dlt-icon" aria-hidden="true"></i>
                                 </a>
                              </td>
                           </tr>
                           @php
                             $sno++;
                           @endphp
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

@endsection
