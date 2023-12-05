@extends('admin.layouts.header')

@section('content')
    <main class="app-content">
        <div class="app-title">
            <div>
                <h1><i class="fa fa-page"></i> Edit Page</h1>
            </div>
        </div>

        
        <!-- inner section start -->

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

        <section class="page-form">
            <!-- tile inner space -->
            <div class="tile">
                <div class="tile-body">
                    <div id="app_content" class="app-container">
                        <!-- add page form start-->
                        
                        <form class="w-100" id="addpage-form" method="POST" action="{{route('page-update')}}" enctype="multipart/form-data">
                          @csrf
                            <!-- form row start at lower div -->
                            <div class=" cst-add-new-form row m-3">
                                <!-- field col  start -->
                                <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12">
                                    <div class="form-group">
                                        <label class="form-head" for="exampletext">
                                            Page Title
                                        </label>
                                        <input class="form-control  @error('page_name') is-invalid @enderror" name="page_name" id="page_name" type="text" value="@if(!empty($page->page_name)){{old('page_name', $page->page_name)}}@endif" placeholder="Enter page page_name"> 
                              
                                          @error('page_name')
                                                <span class="invalid-feedback" role="alert">
                                                    <strong>{{ $message }}</strong>
                                                </span>
                                          @enderror
                                    </div>
                                </div>
                               
                                <!-- mce :: text editor  -->
                                <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12 ">
                                    <div class="form-group">
                                        <label class="form-head" for="exampletext">
                                            Page description
                                        </label>
                                        <textarea id="myTextarea" class="@error('content') is-invalid @enderror" name="content" >@if(!empty($page->page_description)){{old('page_description', $page->page_description)}}@endif</textarea>
                                        @error('content')
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{ $message }}</strong>
                                            </span>
                                         @enderror
                                    </div>
                                     @error('content')
                                        <p style="color:#dc3545; font-size: 80%;" ><strong>{{ $message }}</strong></p>
                                    @enderror
                                </div>
                                <!-- mce :: end text editor  -->
                            </div>
                            <input type="hidden" name="pageid" value="{{$page->id}}">
                            <!-- :: submit button -->
                            <div class="form-group terms mt-2 mb-2">
                                <input type="submit" class="btn btn-info w-100" id=""></input>
                            </div>
                            <!-- :: end submit button -->
                        </form>
                        <!-- add page form up end -->
                    </div>
                </div>
            </div>
            <!-- tile inner space up end -->
        </section>
    </main>
   

@endsection
@section('scripts') 

<script src="https://cdn.tiny.cloud/1/l0xp8n0asjxeoofeo9h30icll510jblob20r38r92ecoyw00/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
<script>
  tinymce.init({
    selector: 'textarea#myTextarea'
  });
</script>

<!-- <script src="https://cdn.jsdelivr.net/npm/@tinymce/tinymce-webcomponent@2/dist/tinymce-webcomponent.min.js"></script> -->
<script src="{{ URL::asset('assets/js/plugins/jquery.dataTables.min.js') }}"></script>
<script src="{{ URL::asset('assets/js/plugins/dataTables.bootstrap.min.js') }}"></script>
<script src="{{ URL::asset('assets/js/plugins/wooenglish_assets_js_dropify.min.js') }}"></script>
<script src="{{ URL::asset('assets/js/plugins/pace.min.js') }}"></script>
<script>
    $('.dropify').dropify();
</script>
@endsection