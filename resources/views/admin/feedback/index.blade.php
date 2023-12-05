@extends('admin.layouts.header')

@section('content')

<main class="app-content">
   <div class="app-title">
            <div>
                <h1><i class="fa fa-feedback-circle"></i> Feedback Information</h1>
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
   <div class="row">
      <div class="col-md-12">
         <div class="tile">
            <div class="tile-body">
               <div class="table-responsive">
                  <table class="table table-hover table-bordered" id="sampleTable">
                     <thead>
                        <tr>
                           <th>Sr.No</th>
                           <th>User Name</th>
                           <th>Email</th>
                           <th>Message</th>
                           <th>Delete</th>
                        </tr>
                     </thead>
                     <tbody>
                      @if(count($feedbacks) > 0)
                        @php
                             $sno = 1;
                        @endphp
                        @foreach($feedbacks as $feedback)
                        <tr>
                           <td>{{$sno}}</td>
                           <td>{{$feedback->name}}</td>
                           <td>{{$feedback->email}}</td>
                           <td>{{$feedback->msg}}</td>
                           <td class="">
                              <a href="#" class="delet-btn demoSwal" id="demoSwal" data-id="{{$feedback->id}}" data-uri="delete-feedback">
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
