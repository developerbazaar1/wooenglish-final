@extends('admin.layouts.header')

@section('content')

<main class="app-content">
   <div class="app-title">
            <div>
                <h1><i class="fa fa-user-circle"></i> User Information</h1>
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
                           <th>Mobile No</th>
                           <th>Status</th>
                           <th>Membership Plan</th>
                           <th>Delete</th>
                        </tr>
                     </thead>
                     <tbody>
                      @if(count($users) > 0)
                        @php
                             $sno = 1;
                        @endphp
                        @foreach($users as $user)
                        <tr>
                           <td>{{$sno}}</td>
                           <td>{{$user->name}}</td>
                           <td>{{$user->email}}</td>
                           <td>{{$user->mobile}}</td>
                           
                           <td class="" id="userstatus<?= $user->id?>">
                            @if($user->status == 'active')
                            <span class="badge badge-success userstatus" id="cst-p-badge">Member</span>
                            @else
                            <span class="badge  badge-danger userstatus">Not Member</span>
                            @endif



                            <span> <a  href="#" class="memb-btn mx-2" id="cst-m-btn" type="button" data-toggle="modal" data-target="#exampleModalLong<?= $user->id?>" title="Update Membership" ><img class="add-icon w-18px"  src="{{ URL::asset('assets/images/updating.png') }}"></a></span>

                                 

       <!-- open edit model start -->
         <div class="modal fade" id="exampleModalLong<?=$user->id ?>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
            <div class="modal-dialog" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="exampleModalLongTitle">
                        <i class="fa fa-pencil px-2" aria-hidden="true"></i>Change User Membership
                     </h5>
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <form  id="edit-user-form<?=$user->id ?>" class="edit-user-form edituser-form w-auto" >
                   
                    <div class="modal-body">
                       <div class="modal-heading text-center">
                          <h1>Membership Plan</h1>
                       </div>
                       <div class="">
                        <input type="hidden" name="user_id"  id="user_id" value="{{$user->id}}">
                         
                          <div class="form-group">
                            <label class="form-head" for="exampletext">
                                Choose Membership Plan
                            </label>
                            <div class="select-group h-40">
                                <select name="membership_plan" id="mem_name<?= $user->id ?>" class="form-control @error('membership_plan') is-invalid @enderror">
                                   <option label="Select"></option>
                                    @if(count($membership_plans) > 0)
                                       @foreach($membership_plans as $membership_plan)
                                         @if ($membership_plan->id ==  $user->membership_plan )
                                             <option value="{{ $membership_plan->id }}" selected>{{ $membership_plan->plan_name }}</option>
                                         @else
                                             <option value="{{ $membership_plan->id }}" >{{$membership_plan->plan_name}}</option>
                                         @endif
                                       @endforeach
                                    @endif
                                 </select>
                                 @error('membership_plan')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                 @enderror
                                
                            </div>
                        </div>
                       </div>
                    </div>
                    <div class="modal-footer">
                       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                       <button type="submit"  data-cat-id="{{$user->id}}" class="cat-submit btn btn-primary">Save changes</button>
                    </div>
                  </form>
               </div>
            </div>
         </div>
       <!-- open edit model end  -->
                              

                           </td>
                           <td id="membershipplan<?= $user->id?>">
                               @php 
                                 if(!empty($user->membership_plan)){
                                 echo $user->membershipplan->plan_name;
                                 }else{
                                 echo "No Plan";
                                 }
                               @endphp
                            </td>
                           <td class="">
                              <a href="#" class="delet-btn demoSwal" id="demoSwal" data-id="{{$user->id}}" data-uri="delete-user">
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
//   $('.demoSwal').click(function(){

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
<script>

  $(function() {

    $('.toggle-class').change(function() {

        var status = $(this).prop('checked') == true ? 1 : 0; 

        var user_id = $(this).data('id'); 

        $.ajax({

            type: "GET",

            dataType: "json",

            url: '/changeuserStatus',

            data: {'status': status, 'user_id': user_id},

            success: function(data){

              console.log(data.success)

            }

        });

    })

  })


  $(".cat-submitggg").click(function(){

        var user_id = $(this).data('cat-id');
        var user_name = $(this).data('cat-name');

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
        $.ajax({

            type: "POST",

            dataType: "json",

            url: '/user/update',

            data: {'user_name': user_name, 'user_id': user_id},

            success: function(data){

              console.log(data.success)

            }

        });


  });



  
 $(".cat-submit").click(function(event){ 
        event.preventDefault();

        var user_id = $(this).data('cat-id');
        var mem_name = $('#mem_name'+user_id).val();

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        formdata = new FormData($('#edit-user-form'+user_id)[0]);

        $.ajax({

            type: "POST",

            dataType: "json",

            url: "{{route('user-update')}}",

            data: formdata,

            processData: false,

            contentType: false,

            success: function(data){
               $('#exampleModalLong'+user_id).modal('hide');
               $('#membershipplan'+user_id).html(mem_name);
               $('#userstatus'+user_id+' .userstatus').removeClass("badge-danger");
               $('#userstatus'+user_id+' .userstatus').addClass("badge-success");
               $('#userstatus'+user_id+' .userstatus').html("Member");
               $('#userstatus'+user_id+' .userstatus').css("padding", '3px 17px 3px 18px');

            }

        });


  });


</script>
@endsection
