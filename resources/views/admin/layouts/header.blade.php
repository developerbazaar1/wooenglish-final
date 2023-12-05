<!DOCTYPE html>
<html lang="en">
  <head>
    <meta property="#" content="#">
    <meta property="#" content="#">
    <meta property="#" content="#">
    <!-- Open Graph Meta-->
    <title>WooEnglish</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="{{ URL::asset('assets/css/main.css') }}">
    <!--favicon-->
     <link rel="icon" type="image/x-icon" href="{{ URL::asset('assets/images/brandlogo.png') }}">
    <!-- Font-icon css-->
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="{{ URL::asset('assets/css/dropify.min.css') }}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  </head>
  
  <body class="app sidebar-mini">

   <header class="app-header"><a class="app-header__logo" href="#">WooEnglish</a>
      <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
      <!-- Navbar Right Menu-->
      <ul class="app-nav">
        <li class="dropdown"><a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Open Profile Menu"><i class="fa fa-user fa-lg"></i></a>
          <ul class="dropdown-menu settings-menu dropdown-menu-right">
            
            <li><a href="{{ route('logout') }}" class="dropdown-item" onclick="event.preventDefault();
                                                     document.getElementById('logout-form').submit();"><i class="fa fa-sign-out fa-lg"></i> Logout</a>
                            <form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">
                @csrf
              </form></li>
          </ul>
        </li>
      </ul>
    </header>

    <!-- Sidebar menu-->
    <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
    <aside class="app-sidebar">
      <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="{{ URL::asset('assets/images/user.png') }}" alt="User Image">
        <div>
          <p class="app-sidebar__user-name">{{ Auth::user()->name }}</p>
          <p class="app-sidebar__user-designation">{{ Auth::user()->user_role }}</p>
        </div>
      </div>
      <ul class="app-menu">
        <li><a class="app-menu__item " href="{{ route('home') }}"><i class="app-menu__icon fa fa-dashboard"></i><span class="app-menu__label">Dashboard</span></a></li>
        <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-book"></i><span class="app-menu__label">Book</span><i class="treeview-indicator fa fa-angle-right"></i></a>
          <ul class="treeview-menu">
            <li><a class="treeview-item" href="{{ route('book-add') }}"><i class="icon fa fa-plus"></i> Add Book</a></li>
            <li><a class="treeview-item" href="{{ route('books') }}"><i class="icon fa fa fa-eye"></i> View Book</a></li>
          </ul>
        </li>
        <li><a class="app-menu__item" href="{{ route('users') }}"><i class="app-menu__icon fa fa-user-circle "></i><span class="app-menu__label">Users</span></a></li>
        <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-th-large"></i><span class="app-menu__label">Masters System</span><i class="treeview-indicator fa fa-angle-right"></i></a>
          <ul class="treeview-menu">
            <li><a class="treeview-item" href="{{ route('categories') }}"><i class="icon fa fa-plus"></i> Add Category</a></li>
            <li><a class="treeview-item" href="{{ route('authors') }}"><i class="icon fa fa-plus"></i> Add Author</a></li>
           <li><a class="treeview-item" href="{{ route('pages') }}"><i class="icon fa fa-plus"></i> Add Page</a></li>
            <li><a class="treeview-item" href="{{ route('info-pages') }}"><i class="icon fa fa-plus"></i> Add Info Page</a></li>
           <li><a class="treeview-item" href="{{ route('thirdpartys') }}"><i class="icon fa fa-plus"></i> Add Third Party Data</a></li>
           <li><a class="treeview-item" href="{{ route('subscriptions') }}"><i class="icon fa fa-plus"></i> Add Subscription</a></li>
          </ul>
        </li>
        <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-bell"></i><span class="app-menu__label">Masters Notification</span><i class="treeview-indicator fa fa-angle-right"></i></a>
          <ul class="treeview-menu">
            <li><a class="treeview-item" href="{{ route('announcements') }}"><i class="icon fa fa-plus"></i>Announcement </a></li>
            <li><a class="treeview-item" href="{{ route('notifications') }}"><i class="icon fa fa-plus"></i> Pushup Notification</a></li>
          </ul>
        </li>
        
        <li><a class="app-menu__item" href="{{ route('get-feedback') }}"><i class="app-menu__icon fa fa-user-circle "></i><span class="app-menu__label">Feedback</span></a></li>
        
        <li><a class="app-menu__item" href="{{ route('get-support') }}"><i class="app-menu__icon fa fa-user-circle "></i><span class="app-menu__label">Support</span></a></li>
        
        <li><a class="app-menu__item" href="{{ route('setting') }}"><i class="app-menu__icon fa fa fa-cogs "></i><span class="app-menu__label">Settings</span></a></li>
      </ul>
     
    </aside>
     
 

    <!--begin::Content-->
    @yield('content')
    <!--end::Content-->

    <!--begin::Footer-->
    @include('admin.layouts.footer')

  </body>
</html>

