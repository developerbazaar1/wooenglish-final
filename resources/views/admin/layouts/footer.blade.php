
    <script src="{{ URL::asset('assets/js/jquery-3.3.1.min.js') }}"></script>
    <script src="{{ URL::asset('assets/js/popper.min.js') }}"></script>
    <script src="{{ URL::asset('assets/js/bootstrap.min.js') }}"></script>
    <script src="{{ URL::asset('assets/js/main.js') }}"></script>
    <script>

    setTimeout(function() {
        $('.alert-danger').fadeOut('fast');
    }, 7000); 

    setTimeout(function() {
        $('.alert-success').fadeOut('fast');
    }, 7000); 
        
    </script>
    @yield('scripts')
    