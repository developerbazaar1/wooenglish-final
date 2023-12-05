@extends('admin.layouts.header')

@section('content')

<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-comments mx-2"></i>View And  Give Answers</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
           @php  $bookid = Crypt::encrypt($quiz_res->book_id);  @endphp
          <li class="breadcrumb-item"><a href="{{ route('quiz-response', $bookid) }}">View Quiz Answers</a></li>
        </ul>
    </div>
    
   <section calss="terms">

        <div class="tile">
            <div class="tile-body">
                <!-- heading row -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="terms-head text-center">
                            <h1> View Answer's</h1>
                        </div>
                    </div>
                </div>
                <!-- content row -->
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
                <div class="row content-row">
                    <div class=" col-md-9 col-lg-9 col-sm-9 col-xs-12 mx-auto mt-3 cst-border-box">
                        @if(count($quizs) > 0)
                           @php
                                $sno = 1;
                           @endphp
                           @foreach($quizs as $quiz)
                            <div class="question-content">
                                <h5> Q{{$sno}}. {{$quiz->question}} </h5>
                                <p>{{$quiz->answer}}
                                </p>
                            </div><hr>
                         @php
                             $sno++;
                           @endphp
                          @endforeach
                         @endif
                        
                        @if(!empty($quiz_res->admin_reply))

                        <div class="question-content">
                            <h5>Reply </h5>
                            <p>{{$quiz_res->admin_reply}}
                            </p>
                        </div><hr>


                        @else

                        <form class="cmnt-form w-100" method="POST" action="{{route('quiz-useranswer-store')}}">
                              @csrf
                            <div class="form-group">
                                <label class="form-head" for="exampleTextarea">Reply</label>
                                <textarea class="form-control @error('admin_reply') is-invalid @enderror" placeholder="Give Reply" id="admin_reply" name="admin_reply" rows="5"></textarea>
                                
                                  @error('admin_reply')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                            </div>
                            
                            <div class="sub-cmnt text-center">
                                <input type="hidden" name="quizresid" value="{{$id}}">
                                <button type="submit" class="btn btn-info w-50 mt-3" id="demoNotify">Submit</button>
                            </div>
                        </form>
                        @endif
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
        window.location.href="/"+uri+"/"+id;
      } else {
        swal("Cancelled", "Your data is safe :)", "error");
      }
    });
  });
  
</script>

@endsection
