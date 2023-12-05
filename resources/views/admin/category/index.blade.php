@extends('admin.layouts.header')

@section('content')

<main class="app-content">
   <div class="app-title">
        <div>
            <h1>
                <i class="fa fa-th-large"></i> Add Category
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
   <section class="add category">
    <!--row start-->
    <div class="cst-add-new-form row justify-content-center">
        <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12">
            <div class="tile">
                <div class="tile-body">
                    <form class="Add-category-form w-auto" method="POST" action="{{route('category-store')}}">
                        @csrf
                        <div class="form-group">
                            <label class="form-head">Category Name</label>
                            <input class="form-control @error('category_name') is-invalid @enderror"
                                name="category_name" id="cat-name" type="text" placeholder="Enter Category Name" />

                            @error('category_name')
                            <span class="invalid-feedback" role="alert">
                                <strong>{{ $message }}</strong>
                            </span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-info w-100" id="demoNotify">
                                Submit Category
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
   <section class="viewcategory">
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
                              <th>Category Name</th>
                              <th>Category Edit</th>
                              <th>Status</th>
                              <th>Delete</th>
                           </tr>
                        </thead>
                        <tbody>
                         @if(count($categories) > 0)
                           @php
                                $sno = 1;
                           @endphp
                           @foreach($categories as $category)
                           <tr>
                              <td>{{$sno}}</td>
                              <td id="cat_name<?=$category->id?>">{{$category->name}}</td>
                              <td class="">
                                 <button class="btn btn-primary btn-sm" id="cst-sm-btn" type="button" data-toggle="modal" data-target="#exampleModalLong<?= $category->id?>">
                                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>Edit </button>

       <!-- open edit model start -->
         <div class="modal fade" id="exampleModalLong<?=$category->id ?>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
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
                  <form  id="edit-category-form" class="edit-category-form editcategory-form w-auto" >
                   
                    <div class="modal-body">
                       <div class="modal-heading text-center">
                          <h1>Book category</h1>
                       </div>
                       <div class="">
                          <div class="form-group">
                             <label class="form-head">category Name</label>
                             <input type="hidden" name="category_id"  id="category_id" value="{{$category->id}}">
                             <input class="form-control" id="category_name<?=$category->id?>" name="category_name" type="text" placeholder="category Name"  value="{{$category->name}}">

                          </div>
                       </div>
                    </div>
                    <div class="modal-footer">
                       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                       <button type="submit"  data-cat-id="{{$category->id}}" class="cat-submit btn btn-primary">Save changes</button>
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
                                       <input data-id="{{$category->id}}" class="toggle-class" type="checkbox" @php if($category->status == 'active'){ echo 'checked'; }  @endphp>
                                       <span class="button-indecator"></span>
                                    </label>
                                 </div>
                              </td>
                              <td class="">
                                 <a href="#" class="delet-btn demoSwal" id="demoSwal" data-id="{{$category->id}}" data-uri="delete-category">
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

        var category_id = $(this).data('id'); 

        $.ajax({

            type: "GET",

            dataType: "json",

            url: '{{ route('changeCategoryStatus') }}',

            data: {'status': status, 'category_id': category_id},

            success: function(data){

              console.log(data.success)

            }

        });

    })

  })


  $(".cat-submit").click(function(event){ 
        event.preventDefault();

        var category_id = $(this).data('cat-id');
        var category_name = $('#category_name'+category_id).val();

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
        $.ajax({

            type: "POST",

            dataType: "json",

            url: "{{route('category-update')}}",

            data: {'category_name': category_name, 'category_id': category_id},

            success: function(data){
               $('#exampleModalLong'+category_id).modal('hide');
               $('#cat_name'+category_id).html(category_name);

            }

        });


  });


</script>
@endsection
