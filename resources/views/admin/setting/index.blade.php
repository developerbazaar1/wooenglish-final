@extends('admin.layouts.header')

@section('content')

<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-cogs"></i> Settings</h1>
        </div>
    </div>
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
    <section class="settingssection">
        <div class="tile">
            <div class="tile-body">
                <div class=" cst-add-new-form row">
                    <!-- field col  start -->
                    <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12">
                        <img class="w-100" src="{{ URL::asset('assets/images/settings-animation.gif') }}">
                    </div>
                    <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12">
                        <form class="admin-setting-form" method="POST" action="{{route('setting-store')}}">
                              @csrf
                            <label> <h2>Update Admin Login Detail</h2></label>
                            <div class="form-group">
                                <label class="form-head" for="exampletext">
                                    PASSWORD
                                </label>
                                <input class="form-control  @error('password') is-invalid @enderror" name="password" id="password" value="{{ old('password') }}" type="password"  placeholder="Enter password">
                                  
                                  @error('password')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                            </div>
                            <div class="form-group mb-4">
                                <label class="form-head" for="exampletext">
                                 CONFIRM PASSWORD
                                </label>
                                <input class="form-control  @error('confirm_password') is-invalid @enderror" name="password_confirmation" id="password_confirmation" type="password"  placeholder="Enter Confirm password">
                                  
                                  @error('password_confirmation')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                  @enderror
                                
                            </div>
                            <div class="form-group">
                            <button type="submit" class="btn btn-info w-100" id="demoNotify">Submit chapter</button>
                        </div>
                        </form>

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


@endsection
