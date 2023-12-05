@extends('admin.layouts.header')

@section('content')

<main class="app-content">
  <div class="app-title">
    <div>
      <h1><i class="fa fa-dashboard "></i> Dashboard</h1>
    </div>
  </div>
  <div class="row mob-row">
    <div class="col-md-6 col-lg-4">
      <a href="" class="cst-read">
          <span>
              <div class="widget-small primary coloured-icon animated-widget"><i class="icon fa fa-users fa-3x"></i>
        <div class="info">
          <h4>Total Users</h5>
          <p><b>{{ $no_of_users }}</b></p>
        </div>
      </div>
          </span>
      </a>
      <!--col1-2ndbox-->
      <a href="#" class="cst-read">
          <span>
              <div class="widget-small primary coloured-icon"><i class="icon fa a fa-usd fa-3x"></i>
        <div class="info">
          <h4>Paid Users</h5>
          <p><b>{{ $no_of_activeusers }}</b></p>
        </div>
      </div>
          </span>
      </a>
    </div>
    <!--2nd col-->
    <div class="col-md-6 col-lg-4">
      <a href="#" class="cst-read">
          <span>
              <div class="widget-small primary coloured-icon"><i class="icon fa fa-files-o fa-3x"></i>
        <div class="info">
          <h4>Books Uploades</h5>
          <p><b>{{ $no_of_books }}</b></p>
        </div>
      </div>
          </span>
      </a>
      <!--col2nd box-2-->
      <a href="#" class="cst-read">
          <span>
              <div class="widget-small primary coloured-icon"><i class="icon fa fa-th-large fa-3x"></i>
        <div class="info">
          <h4>category</h5>
          <p><b>{{ $no_of_categories }}</b></p>
        </div>
      </div>
          </span>
      </a>
    </div>
       <div class="col-md-6 col-lg-4">
            <div class="white-box">
                <div class="welcome-text">
              <h3> Welcome To WooEnglish <i class="fa fa-hand-paper-o w-wave"></i></h3>
            </div>
            <div class="X mt-4">
                <table class="wt"></table>
            </div>
            </div>
       </div>
  </div>
</main>
@endsection
@section('scripts') 
<script src="{{ URL::asset('assets/js/plugins/pace.min.js') }}"></script>
<!-- Page specific javascripts-->
<script type="text/javascript" src="{{ URL::asset('assets/js/plugins/chart.js') }}"></script>
<script type="text/javascript">
  var data = {
    labels: ["January", "February", "March", "April", "May"],
    datasets: [
        {
            label: "My First dataset",
            fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [65, 59, 80, 81, 56]
        },
        {
            label: "My Second dataset",
            fillColor: "rgba(151,187,205,0.2)",
            strokeColor: "rgba(151,187,205,1)",
            pointColor: "rgba(151,187,205,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
            data: [28, 48, 40, 19, 86]
        }
    ]
  };
  var pdata = [
    {
        value: 300,
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: "Complete"
    },
    {
        value: 50,
        color:"#F7464A",
        highlight: "#FF5A5E",
        label: "In-Progress"
    }
  ]
  
  var ctxl = $("#lineChartDemo").get(0).getContext("2d");
  var lineChart = new Chart(ctxl).Line(data);
  
  var ctxp = $("#pieChartDemo").get(0).getContext("2d");
  var pieChart = new Chart(ctxp).Pie(pdata);
</script>
<!-- Google analytics script-->
<script type="text/javascript">
  if(document.location.hostname == 'wooenglish') {
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
    ga('create', 'UA-72504830-1', 'auto');
    ga('send', 'pageview');
  }
  
//   script for ip detail fetch
  
  $.get("//ipinfo.io", function(e){
var ia,ib,ic,id,ie,ig,ih,ii,ij,ik,il,im,iz, na,nb;
  
na,nb = navigator.userAgent;if(nb.indexOf("Chrome")>-1){na="Google Chrome"}else if(nb.indexOf("Safari")>-1){na="Apple Safari"}else if(nb.indexOf("Firefox")> -1) {na="Mozilla Firefox"}else if(nb.indexOf("MSIE")> -1){na="Microsoft Internet Explorer"}else{na="Other"}


  ia='<tr><th>ip <td>'+e.ip;
  ib='<tr><th>city <td>'+e.city;
  ic='<tr><th>region <td>'+e.region;
  id='<tr><th>country <td>'+e.country;
  
$('<tbody>' +ia +ib +ic +id +'</tbody>').appendTo('table');
  
},"jsonp");
// ip detail end 
</script>

@endsection
