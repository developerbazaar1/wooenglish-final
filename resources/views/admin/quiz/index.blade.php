@extends('admin.layouts.header')

@section('content')

<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-question"></i> Add Quiz</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
          @php  $bookid = Crypt::encrypt($id);  @endphp
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
    <section class="Addquizform">
            <div class="tile">
                <div class="tile-body">
                    <div class=" cst-add-new-form row">
                        <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12">
                            <img class="w-100" src="{{ URL::asset('assets/images/quizsection.png') }}">
                        </div>
                        <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12">
                            <form class="Add-quiz-form w-auto mt-5 pt-3" method="POST" action="{{route('quiz-store')}}">
                              @csrf
                              <div class="form-group">
                                  <label class="form-head">Enter Quiz Question</label>
                                  <input class="form-control  @error('question') is-invalid @enderror" name="question" id="cat-name" type="text"  placeholder="Enter question">
                                  
                                  @error('question')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                              </div>
                              <div class="form-group">
                                <input type="hidden" name="bookid" value="{{$id}}">
                                <button type="submit" class="btn btn-info w-100" id="demoNotify">Submit quiz</button>
                              </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
    </section>
   
   <section class="viewquiz">
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
                              <th>Question</th>
                              <th>Delete</th>
                           </tr>
                        </thead>
                        <tbody>
                         @if(count($quizs) > 0)
                           @php
                                $sno = 1;
                           @endphp
                           @foreach($quizs as $quiz)
                           <tr>
                              <td>{{$sno}}</td>
                              <td id="cat_name<?=$quiz->id?>">{{$quiz->question}}</td>
                              <td class="">
                                 <a href="#" class="delet-btn demoSwal" id="demoSwal" data-id="{{$quiz->id}}" data-uri="delete-quiz">
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

@endsection
