@extends('admin.layouts.header')

@section('content')

<main class="app-content">
    <div class="app-title">
        <div>
            <h1>
                <i class="fa fa-pencil"></i> Add Author
            </h1>
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
 <section class="add author">
    <!--row start-->
    <div class="cst-add-new-form row justify-content-center">
        <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12">
            <div class="tile">
                <div class="tile-body">
                    <form class="Add-author-form w-auto" method="POST" action="{{route('author-store')}}"
                        enctype="multipart/form-data">
                        @csrf
                        <div class="form-group">
                            <label class="form-head">Author Name</label>
                            <input class="form-control  @error('author_name') is-invalid @enderror" name="author_name"
                                id="cat-name" type="text" placeholder="Enter Author Name">

                            @error('author_name')
                            <span class="invalid-feedback" role="alert">
                                <strong>{{ $message }}</strong>
                            </span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label class="form-head" for="exampletext">
                                Author Image
                            </label>
                            <input name="document" type="file" class="dropify  @error('document') is-invalid @enderror"
                                data-height="100" data-allowed-file-extensions="jpeg jpg png" />
                            @error('document')
                            <span class="invalid-feedback" role="alert">
                                <strong>{{ $message }}</strong>
                            </span>
                            @enderror
                        </div>
                        @error('document')
                        <p style="color:#dc3545; font-size: 80%;"><strong>{{ $message }}</strong></p>
                        @enderror
                        <div class="form-group">
                            <button type="submit" class="btn btn-info w-100" id="demoNotify">Submit Author</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
   <section class="viewauthor">
      <div class="row">
         @if($message = Session::get('success'))
             <div class="alert alert-success alert-dismissible fade show w-100" role="alert">
               <strong>success!</strong> {{ $message }}
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
                              <th>Author Name</th>
                              <th>Author Image</th>
                              <th>Author Edit</th>
                              <th>Status</th>
                              <th>Delete</th>
                           </tr>
                        </thead>
                        <tbody>
                         @if(count($authors) > 0)
                           @php
                                $sno = 1;
                           @endphp
                           @foreach($authors as $author)
                           <tr>
                              <td>{{$sno}}</td>
                              <td id="cat_name<?=$author->id?>">{{$author->name}}</td>
                              <td class="w-10">
                                <div class="image">
                                  <img id="cat_img<?=$author->id?>" class=" rounded cst-wdh" src="{{ URL::asset('/public/'.$author->author_image) }}" width="100px" alt="">
                                </div>
                              </td>
                              <td class="">
                                 <button class="btn btn-primary btn-sm" id="cst-sm-btn" type="button" data-toggle="modal" data-target="#exampleModalLong<?= $author->id?>">
                                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>Edit </button>

       <!-- open edit model start -->
         <div class="modal fade" id="exampleModalLong<?=$author->id ?>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
            <div class="modal-dialog" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="exampleModalLongTitle">
                        <i class="fa fa-pencil px-2" aria-hidden="true"></i>Edit
                     </h5>
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <form  id="edit-author-form<?=$author->id?>" class="edit-author-form editauthor-form w-auto" enctype="multipart/form-data">
                   
                    <div class="modal-body">
                       <div class="modal-heading text-center">
                          <h1>Book Author</h1>
                       </div>
                       <div class="">
                          <div class="form-group">
                             <label class="form-head">Author Name</label>
                             <input type="hidden" name="author_id"  id="author_id" value="{{$author->id}}">
                             <input class="form-control" id="author_name<?=$author->id?>" name="author_name" type="text" placeholder="author Name"  value="{{$author->name}}">

                          </div>
                           <div class="form-group">
                                    <label class="form-head" for="exampletext">
                                       Author Image
                                    </label>
                                   <input name="document" type="file" data-default-file="{{ URL::asset('/public/'.$author->author_image) }}" class="dropify  @error('document') is-invalid @enderror" data-height="100" data-allowed-file-extensions="jpeg jpg png" />
                                   @error('document')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                   @enderror
                                </div>
                                @error('document')
                                    <p style="color:#dc3545; font-size: 80%;" ><strong>{{ $message }}</strong></p>
                                @enderror
                       </div>
                       <input type="hidden" name="document_old" value="{{$author->author_image}}">
                    </div>
                    <div class="modal-footer">
                       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                       <button type="submit"  data-cat-id="{{$author->id}}" class="cat-submit btn btn-primary">Save changes</button>
                    </div>
                  </form>
               </div>
            </div>
         </div>
       <!-- open edit model end  -->
                              </td>
                              <td class="">
                                 <div class="toggle">
                                    <label>
                                       <!-- <input type="checkbox"> -->
                                       <input data-id="{{$author->id}}" class="toggle-class" type="checkbox" @php if($author->status == 'active'){ echo 'checked'; }  @endphp>
                                       <span class="button-indecator"></span>
                                    </label>
                                 </div>
                              </td>
                              <td class="">
                                 <a href="#" class="delet-btn demoSwal" id="demoSwal" data-id="{{$author->id}}" data-uri="delete-author">
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
<script type="text/javascript" src="{{ URL::asset('assets/js/plugins/wooenglish_assets_js_dropify.min.js') }}"></script>
<script type="text/javascript">

  $('.dropify').dropify();
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
<script>

  $(function() {

    $('.toggle-class').change(function() {

        var status = $(this).prop('checked') == true ? 1 : 0; 

        var author_id = $(this).data('id'); 

        $.ajax({

            type: "GET",

            dataType: "json",

            url: '{{ route('changeauthorStatus') }}',

            data: {'status': status, 'author_id': author_id},

            success: function(data){

              console.log(data.success)

            }

        });

    })

  })


  $(".cat-submit").click(function(event){ 
        event.preventDefault();

        var author_id = $(this).data('cat-id');
        var author_name = $('#author_name'+author_id).val();

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        formdata = new FormData($('#edit-author-form'+author_id)[0]);

        $.ajax({

            type: "POST",

            url: "{{route('author-update')}}",

            data: formdata,

            processData: false,

            contentType: false,

            success: function(data){ 
            
               $('#exampleModalLong'+author_id).modal('hide');
               $('#cat_name'+author_id).html(author_name);
               $('#cat_img'+author_id).attr("src", "public/"+data.formdata.author_image);
            }

        });


  });


</script>
@endsection
