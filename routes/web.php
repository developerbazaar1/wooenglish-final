<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();

Route::middleware(['auth'])->group(function () {

    Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');
    Route::get('/', [App\Http\Controllers\HomeController::class, 'index']);

    // ---------Category Routes ----------------//
    Route::get('/categories', [App\Http\Controllers\CategoryController::class, 'index'])->name('categories');
    Route::get('/category-add', [App\Http\Controllers\CategoryController::class, 'create'])->name('category-add');
    Route::post('/category/store', [App\Http\Controllers\CategoryController::class, 'store'])->name('category-store');
    Route::get('/category/edit/{id}', [App\Http\Controllers\CategoryController::class, 'edit'])->name('category-edit');
    Route::post('/category/update', [App\Http\Controllers\CategoryController::class, 'update'])->name('category-update');
    Route::get('/delete-category/{id}', [App\Http\Controllers\CategoryController::class, 'destroy']); 

    Route::get('/changeCategoryStatus', [App\Http\Controllers\CategoryController::class, 'changeCategoryStatus'])->name('changeCategoryStatus');
   

     // ---------author Routes ----------------//
    Route::get('/authors', [App\Http\Controllers\AuthorController::class, 'index'])->name('authors');
    Route::get('/author-add', [App\Http\Controllers\AuthorController::class, 'create'])->name('author-add');
    Route::post('/author/store', [App\Http\Controllers\AuthorController::class, 'store'])->name('author-store');
    Route::get('/author/edit/{id}', [App\Http\Controllers\AuthorController::class, 'edit'])->name('author-edit');
    Route::post('/author/update', [App\Http\Controllers\AuthorController::class, 'update'])->name('author-update');
    Route::get('/delete-author/{id}', [App\Http\Controllers\AuthorController::class, 'destroy']); 

    Route::get('/changeauthorStatus', [App\Http\Controllers\AuthorController::class, 'changeauthorStatus'])->name('changeauthorStatus');
    
    // ---------User Routes ----------------//
    Route::get('/users', [App\Http\Controllers\UserController::class, 'index'])->name('users');
    Route::post('/user/update', [App\Http\Controllers\UserController::class, 'update'])->name('user-update');
    Route::get('/delete-user/{id}', [App\Http\Controllers\UserController::class, 'destroy']); 

    Route::get('/changeuserStatus', [App\Http\Controllers\UserController::class, 'changeUserStatus']);

    // --------- book routes ----------------

    Route::get('/books', [App\Http\Controllers\BookController::class, 'index'])->name('books');
    Route::get('/book-add', [App\Http\Controllers\BookController::class, 'create'])->name('book-add');
    Route::post('/book/store', [App\Http\Controllers\BookController::class, 'store'])->name('book-store');
    Route::get('/book/edit/{id}', [App\Http\Controllers\BookController::class, 'edit'])->name('book-edit');
    Route::post('/book/update', [App\Http\Controllers\BookController::class, 'update'])->name('book-update');
    Route::get('/delete-book/{id}', [App\Http\Controllers\BookController::class, 'destroy']); 

    Route::get('/changebookStatus', [App\Http\Controllers\BookController::class, 'changebookStatus'])->name('changebookStatus');

    // video
    Route::get('/video-add/{id}', [App\Http\Controllers\BookController::class, 'addvideo'])->name('video-add');
    Route::post('/video/store', [App\Http\Controllers\BookController::class, 'storevideo'])->name('video-store');
    Route::get('/delete-video/{id}', [App\Http\Controllers\BookController::class, 'destroyvideo']); 

    // audio
    Route::get('/audio-add/{id}', [App\Http\Controllers\BookController::class, 'addaudio'])->name('audio-add');
    Route::post('/audio/store', [App\Http\Controllers\BookController::class, 'storeaudio'])->name('audio-store');
    Route::get('/delete-audio/{id}', [App\Http\Controllers\BookController::class, 'destroyaudio']);

    // reviews

     Route::get('/reviews/{id}', [App\Http\Controllers\ReviewController::class, 'index'])->name('reviews');
     Route::get('/delete-review/{id}', [App\Http\Controllers\ReviewController::class, 'destroy']); 

     Route::post('/review/update', [App\Http\Controllers\ReviewController::class, 'update'])->name('review-update');

      // ---------quiz Routes ----------------//
    Route::get('/quizs/{id}', [App\Http\Controllers\QuizController::class, 'index'])->name('quizs');
    Route::get('/quiz-add', [App\Http\Controllers\QuizController::class, 'create'])->name('quiz-add');
    Route::post('/quiz/store', [App\Http\Controllers\QuizController::class, 'store'])->name('quiz-store');
    Route::get('/quiz/edit/{id}', [App\Http\Controllers\QuizController::class, 'edit'])->name('quiz-edit');
    Route::post('/quiz/update', [App\Http\Controllers\QuizController::class, 'update'])->name('quiz-update');
    Route::get('/delete-quiz/{id}', [App\Http\Controllers\QuizController::class, 'destroy']); 

    Route::get('/changequizStatus', [App\Http\Controllers\QuizController::class, 'changequizStatus']);

    Route::get('/quiz-response/{id}', [App\Http\Controllers\QuizController::class, 'quiz_response'])->name('quiz-response');
    Route::get('/delete-quizresponse/{id}', [App\Http\Controllers\QuizController::class, 'destroyquizresponse']); 

    Route::get('/quiz-user-answer/{id}', [App\Http\Controllers\QuizController::class, 'quiz_useranswer'])->name('quiz-user-answer');
    Route::post('/quiz/useranswer-store', [App\Http\Controllers\QuizController::class, 'quiz_useranswer_store'])->name('quiz-useranswer-store');

  // ---------chapter Routes ----------------//
    Route::get('/chapters/{id}', [App\Http\Controllers\ChapterController::class, 'index'])->name('chapters');
    Route::get('/chapter-add', [App\Http\Controllers\ChapterController::class, 'create'])->name('chapter-add');
    Route::post('/chapter/store', [App\Http\Controllers\ChapterController::class, 'store'])->name('chapter-store');
    Route::get('/chapter/edit/{id}', [App\Http\Controllers\ChapterController::class, 'edit'])->name('chapter-edit');
    Route::post('/chapter/update', [App\Http\Controllers\ChapterController::class, 'update'])->name('chapter-update');
    Route::get('/delete-chapter/{id}', [App\Http\Controllers\ChapterController::class, 'destroy']); 

    Route::get('/changechapterStatus', [App\Http\Controllers\ChapterController::class, 'changechapterStatus']);


    // setting
     Route::get('/setting', [App\Http\Controllers\HomeController::class, 'setting'])->name('setting');
     Route::post('/setting-store', [App\Http\Controllers\HomeController::class, 'storesetting'])->name('setting-store');

     // ---------page Routes ----------------//
    Route::get('/pages', [App\Http\Controllers\PageController::class, 'index'])->name('pages');
    Route::get('/page-add', [App\Http\Controllers\PageController::class, 'create'])->name('page-add');
    Route::post('/page/store', [App\Http\Controllers\PageController::class, 'store'])->name('page-store');
    Route::get('/page/edit/{id}', [App\Http\Controllers\PageController::class, 'edit'])->name('page-edit');
    Route::post('/page/update', [App\Http\Controllers\PageController::class, 'update'])->name('page-update');
    Route::get('/delete-page/{id}', [App\Http\Controllers\PageController::class, 'destroy']); 

    Route::get('/changepageStatus', [App\Http\Controllers\PageController::class, 'changepageStatus']);

    // ---------thirdparty Routes ----------------//
    Route::get('/thirdpartys', [App\Http\Controllers\ThirdpartyController::class, 'index'])->name('thirdpartys');
    Route::get('/thirdparty-add', [App\Http\Controllers\ThirdpartyController::class, 'create'])->name('thirdparty-add');
    Route::post('/thirdparty/store', [App\Http\Controllers\ThirdpartyController::class, 'store'])->name('thirdparty-store');
    Route::get('/thirdparty/edit/{id}', [App\Http\Controllers\ThirdpartyController::class, 'edit'])->name('thirdparty-edit');
    Route::post('/thirdparty/update', [App\Http\Controllers\ThirdpartyController::class, 'update'])->name('thirdparty-update');
    Route::get('/delete-thirdparty/{id}', [App\Http\Controllers\ThirdpartyController::class, 'destroy']); 

    Route::get('/changethirdpartyStatus', [App\Http\Controllers\ThirdpartyController::class, 'changethirdpartyStatus']);


    // ---------subscription Routes ----------------//
    Route::get('/subscriptions', [App\Http\Controllers\SubscriptionController::class, 'index'])->name('subscriptions');
    Route::get('/subscription-add', [App\Http\Controllers\SubscriptionController::class, 'create'])->name('subscription-add');
    Route::post('/subscription/store', [App\Http\Controllers\SubscriptionController::class, 'store'])->name('subscription-store');
    Route::get('/subscription/edit/{id}', [App\Http\Controllers\SubscriptionController::class, 'edit'])->name('subscription-edit');
    Route::post('/subscription/update', [App\Http\Controllers\SubscriptionController::class, 'update'])->name('subscription-update');
    Route::get('/delete-subscription/{id}', [App\Http\Controllers\SubscriptionController::class, 'destroy']); 

    Route::get('/changesubscriptionStatus', [App\Http\Controllers\SubscriptionController::class, 'changesubscriptionStatus'])->name('changesubscriptionStatus');

     // ---------announcement Routes ----------------//
    Route::get('/announcements', [App\Http\Controllers\AnnouncementController::class, 'index'])->name('announcements');
    Route::get('/announcement-add', [App\Http\Controllers\AnnouncementController::class, 'create'])->name('announcement-add');
    Route::post('/announcement/store', [App\Http\Controllers\AnnouncementController::class, 'store'])->name('announcement-store');
    Route::get('/announcement/edit/{id}', [App\Http\Controllers\AnnouncementController::class, 'edit'])->name('announcement-edit');
    Route::post('/announcement/update', [App\Http\Controllers\AnnouncementController::class, 'update'])->name('announcement-update');
    Route::get('/delete-announcement/{id}', [App\Http\Controllers\AnnouncementController::class, 'destroy']); 

    Route::get('/changeannouncementStatus', [App\Http\Controllers\AnnouncementController::class, 'changeannouncementStatus']);


     // ---------notification Routes ----------------//
    Route::get('/notifications', [App\Http\Controllers\NotificationController::class, 'index'])->name('notifications');
    Route::get('/notification-add', [App\Http\Controllers\NotificationController::class, 'create'])->name('notification-add');
    Route::post('/notification/store', [App\Http\Controllers\NotificationController::class, 'store'])->name('notification-store');
    Route::get('/notification/edit/{id}', [App\Http\Controllers\NotificationController::class, 'edit'])->name('notification-edit');
    Route::post('/notification/update', [App\Http\Controllers\NotificationController::class, 'update'])->name('notification-update');
    Route::get('/delete-notification/{id}', [App\Http\Controllers\NotificationController::class, 'destroy']); 

    Route::get('/changenotificationStatus', [App\Http\Controllers\NotificationController::class, 'changenotificationStatus']);
   
   
   
    Route::get('/get-feedback', [App\Http\Controllers\HomeController::class, 'get_feedback'])->name('get-feedback');
    Route::get('/delete-feedback/{id}', [App\Http\Controllers\HomeController::class, 'destroy_feedback']); 
     
    Route::get('/get-support', [App\Http\Controllers\HomeController::class, 'get_support'])->name('get-support');
    Route::get('/delete-support/{id}', [App\Http\Controllers\HomeController::class, 'destroy_support']);
    
      // ---------info page Routes ----------------//
    Route::get('/info-pages', [App\Http\Controllers\InfoPageController::class, 'index'])->name('info-pages');
    Route::get('/info-page-add', [App\Http\Controllers\InfoPageController::class, 'create'])->name('info-page-add');
    Route::post('/info-page/store', [App\Http\Controllers\InfoPageController::class, 'store'])->name('info-page-store');
    Route::get('/info-page/edit/{id}', [App\Http\Controllers\InfoPageController::class, 'edit'])->name('info-page-edit');
    Route::post('/info-page/update', [App\Http\Controllers\InfoPageController::class, 'update'])->name('info-page-update');
    Route::get('/delete-info-page/{id}', [App\Http\Controllers\InfoPageController::class, 'destroy']); 
   
});

