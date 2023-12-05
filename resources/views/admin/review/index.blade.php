@extends('admin.layouts.header')

@section('content')

<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-user"></i> User Reviews</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
          <li class="breadcrumb-item"><a href="{{ route('books') }}">View Books</a></li>
        </ul>
    </div>

   

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
                                <th>Reviewer Name</th>
                                <th>Rating</th>
                                <th>Review</th>
                                <th>Reply</th>
                                <th>Action</th>
                           </tr>
                        </thead>
                        <tbody>
                         @if(count($reviews) > 0)
                           @php
                                $sno = 1;
                           @endphp
                           @foreach($reviews as $review)
                           <tr>
                              <td>{{$sno}}</td>
                              <td>{{$review->name}}</td>
                              <td class="rate">
                               
                                                        
                                @if($review->rating !== null)
                                    <div class="star-rating">
                                        @for($i = 1; $i <= 5; $i++)
                                            @if($review->rating >= $i)
                                                <span class="fa fa-star checked"></span>
                                            @elseif($review->rating >= $i - 0.5)

                                                <span class="fa fa-star-half-o checked"></span>
                                            @else
                                                <!--<span class="fa fa-star "></span>-->
                                            @endif
                                        @endfor
                                    </div>
                                @else
                                    <p>No ratings yet.</p>
                                @endif
        
                                </td>
                              <td>{{$review->review}}</td>
                              <td class="">
                                 <button class="btn btn-primary btn-sm" id="cst-sm-btn" type="button" data-toggle="modal" data-target="#exampleModalLong<?= $review->id?>">
                                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>Reply </button>

       <!-- open edit model start -->
         <div class="modal fade" id="exampleModalLong<?=$review->id ?>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
            <div class="modal-dialog" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="exampleModalLongTitle">
                        <i class="fa fa-pencil px-2" aria-hidden="true"></i>Reply
                     </h5>
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <form  id="edit-review-form<?=$review->id?>" class="review-reply-form w-auto" >
                   
                    <div class="modal-body">
                       
                          <div class="form-group">
                             <label class="form-head">Give Reply</label>
                             <input type="hidden" name="review_id"  id="review_id" value="{{$review->id}}">
                             
                              <textarea id="reply" class="@error('reply') is-invalid @enderror form-control" rows="5" name="content" placeholder="Add Reply">@if(!empty($review->reply)){{old('reply', $review->reply)}}@endif</textarea>
                                        @error('reply')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                         @enderror
                             

                          </div>
                       
                    </div>
                    <div class="modal-footer">
                       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                       <button type="submit"  data-cat-id="{{$review->id}}" class="cat-submit btn btn-primary">Send</button>
                    </div>
                  </form>
               </div>
            </div>
         </div>
       <!-- open edit model end  -->
                              </td>
                              <td class="">
                                 <a href="#" class="delet-btn demoSwal" id="demoSwal" data-id="{{$review->id}}" data-uri="delete-review">
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



 $(".cat-submit").click(function(event){ 
        event.preventDefault();

        var review_id = $(this).data('cat-id');
      

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        formdata = new FormData($('#edit-review-form'+review_id)[0]);

        $.ajax({

            type: "POST",

            dataType: "json",

            url: "{{route('review-update')}}",

            data: formdata,

            processData: false,

            contentType: false,

            success: function(data){
               $('#exampleModalLong'+review_id).modal('hide');
           

            }

        });


  });

  
</script>



@endsection
