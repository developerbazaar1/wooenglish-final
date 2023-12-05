 @extends('admin.layouts.header')

@section('content')

<main class="app-content">
   <div class="app-title">
        <div>
            <h1><i class="fa-sharp fa-solid fa-circle-exclamation"></i> Subscription</h1>
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
     
   <section class="add subscription">
        <div class="tile">
            <div class="tile-body">
                <!--row start-->
                <div class=" cst-add-new-form row">
                    <!--col-1-->
                    <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12 text-center">
                        <img class="master-image w-100" src="{{ URL::asset('assets/images/subscription-img.png') }}">
                    </div>
                    <!--end col-1-->
                    <!--col-2-->
                    <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12">
                        <form class="Add-subscription-form w-auto" method="POST" action="{{route('subscription-store')}}">
                          @csrf
                          <div class="form-group">
                              <label class="form-head">Plan Name</label>
                              <input class="form-control  @error('plan_name') is-invalid @enderror" name="plan_name" id="cat-name" type="text" value="{{ old('plan_name') }}" placeholder="Enter Plan Name">
                              
                              @error('plan_name')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                              @enderror
                          </div>

                          <div class="form-group">
                                <label class="form-head" for="exampleDuration">
                                    Plan Duration
                                </label>
                                <div class="input-group">
                                    <input class="form-control  @error('plan_duration') is-invalid @enderror" name="plan_duration" value="{{ old('plan_duration') }}" id="exampleInputDuration1" type="number"  placeholder="Enter Plan Duration">
                              
                                      @error('plan_duration')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                      @enderror
                                    <select name="plan_period" id="plan_period" class="orm-select w-10 @error('plan_period') is-invalid @enderror">
                                      
                                        @if(count($plan_periods) > 0)
                                           @foreach($plan_periods as $plan_period)
                                             @if ($plan_period->name ==  old('plan_period') )
                                                 <option value="{{ $plan_period->name }}" selected>{{ $plan_period->name }}</option>
                                             @else
                                                 <option value="{{ $plan_period->name }}" >{{$plan_period->name}}</option>
                                             @endif
                                           @endforeach
                                        @endif
                                    </select>
                                     @error('plan_period')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                     @enderror

                                </div>
                          </div>
                          <div class="form-group">
                              <label class="form-head">Price</label>
                              <input class="form-control  @error('plan_price') is-invalid @enderror" name="plan_price" id="cat-name" value="{{ old('plan_price') }}" type="text"  placeholder="Enter Plan Price">
                              
                              @error('plan_price')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                              @enderror
                          </div>
                          <div class="form-group">
                                <div class="toggle mt-4">
                                  <label>
                                    <input type="checkbox" name="status"><span class="button-indecator"><span>Please select the status of the plan (Active/inactive)</span>
                                   </span></label>
                                </div>
                            </div>
                          <div class="form-group">
                            <button type="submit" class="btn btn-info w-100" id="demoNotify">Submit subscription</button>
                          </div>
                        </form>
                    </div>
                    <!--end col-2-->
                </div>
            </div>
        </div>
   </section>
   <section class="viewsubscription">
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
                              <th>Plan Name</th>
                              <th>Plan Duration</th>
                              <th>Price</th>
                              <th>Status</th>
                              <th>Delete</th>
                           </tr>
                        </thead>
                        <tbody>
                         @if(count($subscriptions) > 0)
                           @php
                                $sno = 1;
                           @endphp
                           @foreach($subscriptions as $subscription)
                           <tr>
                              <td>{{$sno}}</td>
                              <td>{{$subscription->plan_name}}</td>
                              <td>{{$subscription->plan_duration}}{{$subscription->plan_period}}</td>
                              <td>{{$subscription->plan_price}}</td>
                             
                              <td class="">
                                 <div class="toggle">
                                    <label>
                                       <!-- <input type="checkbox"> -->
                                       <input data-id="{{$subscription->id}}" class="toggle-class" type="checkbox" @php if($subscription->status == 'active'){ echo 'checked'; }  @endphp>
                                       <span class="button-indecator"></span>
                                    </label>
                                 </div>
                              </td>
                              <td class="">
                                 <a href="#" class="delet-btn demoSwal" id="demoSwal" data-id="{{$subscription->id}}" data-uri="delete-subscription">
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
<script>

  $(function() {

    $('.toggle-class').change(function() {

        var status = $(this).prop('checked') == true ? 1 : 0; 

        var subscription_id = $(this).data('id'); 

        $.ajax({

            type: "GET",

            dataType: "json",

            url: '{{ route('changesubscriptionStatus') }}',

            data: {'status': status, 'subscription_id': subscription_id},

            success: function(data){

              console.log(data.success)

            }

        });

    })

  })


  $(".cat-submit").click(function(event){ 
        event.preventDefault();

        var subscription_id = $(this).data('cat-id');
        var plan_name = $('#plan_name'+subscription_id).val();

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
        $.ajax({

            type: "POST",

            dataType: "json",

            url: "{{route('subscription-update')}}",

            data: {'plan_name': plan_name, 'subscription_id': subscription_id},

            success: function(data){
               $('#exampleModalLong'+subscription_id).modal('hide');
               $('#cat_name'+subscription_id).html(plan_name);

            }

        });


  });


</script>
@endsection
