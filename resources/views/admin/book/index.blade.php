@extends('admin.layouts.header')

@section('content')

<main class="app-content">
   <div class="app-title">
        <div>
            <h1>
                <i class="fa fa-th-large"></i> View Book
            </h1>
        </div>
    </div>

 
   <section class="viewbook">
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
                              <th>Book Image</th>
                              <th>Title</th>
                              <th>Publish Date</th>
                              <th>Status</th>
                              <th>Review</th>
                              <th>Quiz</th>
                              <th>Action</th>
                           </tr>
                        </thead>
                        <tbody>
                         @if(count($books) > 0)
                           @php
                                $sno = 1;
                           @endphp
                           @foreach($books as $book)
                           <tr>
                              <td>{{$sno}}</td>
                              <td class="w-10">
                                <div class="image">
                                  <img class=" rounded cst-wdh" src="{{ URL::asset('/public/'.$book->book_thumbnail) }}" width="100px" alt="">
                                </div>
                              </td>
                              <td>{{$book->title}}</td>
                              <td>{{$book->created_at}}</td>
                             
                              <td class="">
                                 <div class="toggle">
                                    <label>
                                       <!-- <input type="checkbox"> -->
                                       <input data-id="{{$book->id}}" class="toggle-class" type="checkbox" @php if($book->status == 'active'){ echo 'checked'; }  @endphp>
                                       <span class="button-indecator"></span>
                                    </label>
                                 </div>
                              </td>
                              <td>
                                @php  $bookid = Crypt::encrypt($book->id);  @endphp
                                <a href="{{route('reviews', $bookid)}}" class="review-link text-blue-underline">reviews</a>
                              </td>
                              <td><a href="{{ route('quiz-response', $bookid)}}" class="view-quiz text-blue-underline">view</a></td>
                              <td class="">
                                <span>
                                  <a href="{{route('book-edit', $bookid)}}" class="delet-btn px-3">
                                    <i class=" fa fa-pencil-square-o" aria-hidden="true"></i>
                                  </a>
                                </span>
                                <span>
                                  <a href="#" class="delet-btn demoSwal" id="demoSwal" data-id="{{$book->id}}" data-uri="delete-book">
                                    <i class=" fa fa-trash-o dlt-icon" aria-hidden="true"></i>
                                  </a>
                                </span>
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

        var book_id = $(this).data('id'); 

        $.ajax({

            type: "GET",

            dataType: "json",

            url: '{{ route('changebookStatus') }}',

            data: {'status': status, 'book_id': book_id},

            success: function(data){

              console.log(data.success)

            }

        });

    })

  })


  $(".cat-submit").click(function(event){ 
        event.preventDefault();

        var book_id = $(this).data('cat-id');
        var book_name = $('#book_name'+book_id).val();

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
        $.ajax({

            type: "POST",

            dataType: "json",

            url: "{{route('book-update')}}",

            data: {'book_name': book_name, 'book_id': book_id},

            success: function(data){
               $('#exampleModalLong'+book_id).modal('hide');
               $('#cat_name'+book_id).html(book_name);

            }

        });


  });


</script>
@endsection
