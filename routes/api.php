<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware(['auth:sanctum'])->group(function () {


    Route::get('/user', 'App\Http\Controllers\Api\UserController@index');

    Route::get('/books/get-popular', 'App\Http\Controllers\Api\BookController@get_popular');

    Route::get('/books/get-recommended', 'App\Http\Controllers\Api\BookController@get_recommended');

    Route::get('/books/get-new-release', 'App\Http\Controllers\Api\BookController@get_new_release');

    Route::get('/books/get-members-data', 'App\Http\Controllers\Api\BookController@get_members_data');

    Route::get('/get-authors', 'App\Http\Controllers\Api\BookController@get_authors');

    Route::get('/books/dashboard-data', 'App\Http\Controllers\Api\BookController@get_dashboard_data');

    Route::post('/books/add-view-count', 'App\Http\Controllers\Api\BookController@add_view_count');
    
    Route::get('/user/get-favorite', 'App\Http\Controllers\Api\UserController@get_user_favorite_data');

    Route::post('/user/follow-author', 'App\Http\Controllers\Api\UserController@follow_author');

    Route::post('/user/favorite-book', 'App\Http\Controllers\Api\UserController@favorite_book');

    Route::get('/author', 'App\Http\Controllers\Api\BookController@author_details_with_books_and_review');

    Route::get('/book', 'App\Http\Controllers\Api\BookController@book_details_with_review');
    
    Route::get('/book-reviews', 'App\Http\Controllers\Api\BookController@book_details_all_reviews');

    Route::get('/similar-recomandation', 'App\Http\Controllers\Api\BookController@similar_recomandation');
    
    Route::post('/book/post-user-review', 'App\Http\Controllers\Api\UserController@post_user_review');

    Route::get('/book-read-listen', 'App\Http\Controllers\Api\BookController@book_chapters_with_audio');
    
    Route::get('/book/video-details', 'App\Http\Controllers\Api\BookController@book_details_with_video');

    Route::get('/book/quiz', 'App\Http\Controllers\Api\QuizController@get_quiz');

    Route::post('/book/quiz-user-answers', 'App\Http\Controllers\Api\QuizController@quiz_user_answer');

    Route::get('/book/quiz-reply', 'App\Http\Controllers\Api\QuizController@get_quiz_reply');

    Route::get('/get-announcement', 'App\Http\Controllers\Api\UserController@get_announcement');
    
    Route::get('/get-notification', 'App\Http\Controllers\Api\UserController@get_notification');
    
    Route::get('/get-pages', 'App\Http\Controllers\Api\UserController@get_pages');
    
    Route::get('/user/review', 'App\Http\Controllers\Api\UserController@my_review');

    Route::get('/user/quiz', 'App\Http\Controllers\Api\QuizController@get_user_quiz');
    
    Route::get('/user/quiz-book-wise', 'App\Http\Controllers\Api\QuizController@get_user_quiz_book_wise');

    Route::post('/support', 'App\Http\Controllers\Api\UserController@support');
    
    Route::post('/feedback', 'App\Http\Controllers\Api\UserController@feedback');
    
    Route::post('/firebase-token', 'App\Http\Controllers\Api\UserController@firebase_token');

    Route::post('/user/bookmark-book', 'App\Http\Controllers\Api\UserController@bookmark_book');

    Route::get('/user/bookmarks', 'App\Http\Controllers\Api\UserController@get_bookmarks');

    Route::post('/book/add-view-book', 'App\Http\Controllers\Api\BookController@add_view_book');

    Route::post('/book/add-finish-book', 'App\Http\Controllers\Api\BookController@add_finish_book');

    Route::post('/book/get-any-view-book-status', 'App\Http\Controllers\Api\BookController@get_any_view_book_status');

    Route::get('/get-continue-book-status', 'App\Http\Controllers\Api\BookController@get_continue_book_status');

    Route::get('/get-all-view-books', 'App\Http\Controllers\Api\BookController@get_all_view_books');

    Route::get('/get-finish-books', 'App\Http\Controllers\Api\BookController@get_finish_books');

    Route::get('/book/search/{bookname}', 'App\Http\Controllers\Api\BookController@searchby_bookname');

    Route::get('/search-by-filter', 'App\Http\Controllers\Api\BookController@searchby_filter');
    
    Route::get('/search-by-author', 'App\Http\Controllers\Api\BookController@searchby_authorname');

    Route::get('/get-category', 'App\Http\Controllers\Api\BookController@get_category');

    Route::get('/get-english-accent', 'App\Http\Controllers\Api\BookController@get_english_accent');

    Route::get('/get-level', 'App\Http\Controllers\Api\BookController@get_level');
    
    Route::get('/get-length', 'App\Http\Controllers\Api\BookController@get_length');
    
    Route::get('/get-language', 'App\Http\Controllers\Api\BookController@get_language');

    Route::get('/notification-on-off', 'App\Http\Controllers\Api\UserController@notification_on_off');
    Route::get('/app-update', 'App\Http\Controllers\Api\UserController@app_update'); 
    Route::get('/mode-change', 'App\Http\Controllers\Api\UserController@mode_change'); 
    
    Route::post('/update-profile', 'App\Http\Controllers\Api\UserController@update_profile');
    
    Route::get('/delete-review', 'App\Http\Controllers\Api\BookController@destroy_review');
    
    Route::get('/get-greeting', 'App\Http\Controllers\Api\UserController@get_greeting');
    
    Route::post('/logout', 'App\Http\Controllers\Api\AuthController@logout');
    
    Route::get('/subscriptions', 'App\Http\Controllers\Api\SubscriptionController@index');
    
    Route::post('/payment-update', 'App\Http\Controllers\Api\UserController@payment_update');

});


Route::post('/auth/login', 'App\Http\Controllers\Api\AuthController@loginUser');

Route::post('/auth/register', 'App\Http\Controllers\Api\AuthController@createUser');

Route::post('/auth/login-with-otp', 'App\Http\Controllers\Api\AuthController@loginWithOtp');    

Route::post('/auth/sso', 'App\Http\Controllers\Api\AuthController@sso');

 Route::get('/get-info-pages', 'App\Http\Controllers\Api\UserController@get_infopages');