// ignore_for_file: non_constant_identifier_names

class ApiKey {
  ///COMMON
  static const accept = "Accept";
  static const applicationJson = "application/json";
  static const token = "token";
  static const authorization = "Authorization";
  static const bearer = "Bearer";
  static const status = "status";
  static const message = "message";
  static const limit="limit";
  static const offset="offset";

  ///Registration/Login
  static const name = "name";
  static const email = "email";
  static const mobile = "mobile";
  static const deviceType = "device_type";
  static const countryCode = "country_code";
  static const provider = "provider";
  static const google = "google";
  static const facebook = "facebook";

  ///Login With Otp
  // ignore: constant_identifier_names
  static const user_id = "user_id";
  static const otp = "otp";
  static const isRequired = "is_required";

  ///Dashboard
  static var isDashboard="is_dashboard";
  static const bookTitle = "book_title";
  static const popularBooks = "popularBooks";
  static const recommendedBooks = "recommendedBooks";
  static const newReleaseBooks = "newReleaseBooks";
  static const memberBooks = "memberBooks";
  static const authors = "authors";
  static const isAudio = "is_audio";

  ///Author
  static const authorId="author_id";

  ///User
  static const msg = "msg";
  static var data="data";
  static var document="document";
  static var documentOld="document_old";
  static var notification="notification";
  static var appUpdate="app_update";


  ///BOOK DETAILS
  static var categoryId="category_id";
  static var bookId="book_id";
  static var bookIdForBookReview="Book_id";
  static var review="review";
  static var reviewId="review_id";
  static var rating="rating";
  static var inBookDetails="in_book_details";
  static var question="question";
  static var answer="answer";
  static var chapter="chapter";
  static var video="video";
  static var genre="genre";
  static var level="level";
  static var language="language";
  static var length="length";


  ///Terms and condition OR  Privacy Policy
  static var pageName="page_name";
  static var termsAndCondition="Terms And Condition";
  static var privacyPolicy="Privacy Policy";

  ///SEARCH
  static var bookName="book_name";
  static var topBooks="top_books";

  static var category="category";

  static var englishAccent="english_accent";
  static var quizId="quiz_id";

  static var fcmId="fcmid";

  static var chapterId="chapter_id";

  static var mode="mode";

  static var search="search";


  /// QUIZ DETAILS
   static var comment="comment";


 /// READ BOOK
  static var setFontStyle="setFontStyle";
  static var setImage="setImage";
  static var setTextAlign="setTextAlign";
  static var isDarkmode="isDarkmode";
  static var setFontFamily="setFontFamily";
  static var formated_id="formated_id";
  static var textColor="textColor";
  static var backGroundColor="backGroundColor";
  static var selectFontSize="selectFontSize";


}

class UriConstant {
  //BASEURL
  static const baseUrl = "https://hostingbazaar.in/WooEnglish/";
  static const baseUriForParams = "hostingbazaar.in";

  //LOGIN ,SIGNUP , LOGOUT
  static const endPointRegistration = "${baseUrl}api/auth/register";
  static const endPointLogin = "${baseUrl}api/auth/login";
  static const endPointSsoLogin = "${baseUrl}api/auth/sso";
  static const endPointMatchOtp = "${baseUrl}api/auth/login-with-otp";
  static const endPointLogOut = "${baseUrl}api/logout";
  static const endPointGetInfoPages = "${baseUrl}api/get-info-pages";

  //DASHBOARD

  static const endPointGetGreeting = "${baseUrl}api/get-greeting";
  static const endPointGetContinueBook = "${baseUrl}api/get-continue-book-status";
  static const endPointGetDashBoardData = "/WooEnglish/api/books/dashboard-data";
  static const endPointGetPopularBooks = "/WooEnglish/api/books/get-popular";
  static const endPointGetRecommendedBooks = "/WooEnglish/api/books/get-recommended";
  static const endPointGetFavoriteBooks = "/WooEnglish/api/user/get-favorite";
  static const endPointGetMemberBooks = "/WooEnglish/api/books/get-members-data";
  static const endPointGetNewReleaseBooks = "/WooEnglish/api/books/get-new-release";

  //AUTHOR
  static const endPointGetAuthors = "/WooEnglish/api/get-authors";
  static const endPointGetAuthorDetail = "/WooEnglish/api/author";
  static const endPointFollowAuthor = "${baseUrl}api/user/follow-author";

  //USER
  static const endPointGetUserData = "${baseUrl}api/user";
  static const endPointUpdateUserProfile = "${baseUrl}api/update-profile";
  static const endPointAddViewBook = "${baseUrl}api/book/add-view-book";
  static const endPointGetUserViewBook = "/WooEnglish/api/get-all-view-books";
  static const endPointAddBookMark= "${baseUrl}api/user/bookmark-book";
  static const endPointGetUserBookMarks = "/WooEnglish/api/user/bookmarks";
  static const endPointPostUserReview = "${baseUrl}api/book/post-user-review";
  static const endPointGetUserReview = "/WooEnglish/api/user/review";
  static const endPointDeleteUserReview = "/WooEnglish/api/delete-review";
  static const endPointAddFinishedBook = "${baseUrl}api/book/add-finish-book";
  static const endPointGetUserFinishedBooks = "WooEnglish/api/get-finish-books";
  static const endPointAddUserFavorite = "${baseUrl}api/user/favorite-book";
  static const endPointGetUserQuiz = "WooEnglish/api/user/quiz";
  static const endPointNotificationOnOff = "WooEnglish/api/notification-on-off";
  static const endPointAppUpdateOnOff = "WooEnglish/app-update";
  static const endPointDarkModeOnOff = "WooEnglish/api/mode-change";
  static const endPointFeedback="${baseUrl}api/feedback";
  static const endPointHelpAndSupport = "${baseUrl}api/support";
  static const endPointFirebaseToken = "${baseUrl}api/firebase-token";

  //SEARCH
  static const endPointGetLanguage = "${baseUrl}api/get-language";
  static const endPointGetLength = "${baseUrl}api/get-length";
  static const endPointGetCategory = "${baseUrl}api/get-category";
  static const endPointGetGenre = "${baseUrl}api/get-genre";
  static const endPointGetLevel = "${baseUrl}api/get-level";
  static const endPointGetEnglishAssent = "${baseUrl}api/get-english-accent";
  static const endPointGetSearchList = "/WooEnglish/api/search-by-filter";


  static const  endPointAddViewCountApi = "${baseUrl}api/books/add-view-count";
  //NOTIFICATION
  static const endPointGetNotification = "WooEnglish/api/get-notification";

  //BOOKDETAIL
  static const endPointGetBookDetail = "WooEnglish/api/book";
  static const  endPointGetSimilarBook = "WooEnglish/api/similar-recomandation";
  static const  FendPointAddViewCountApi = "${baseUrl}api/books/add-view-count";

  //REVIEW
  static const endPointSubmitReview = "${baseUrl}api/book/post-user-review";
  static const endPointGetBookReview = "WooEnglish/api/book-reviews";

  //VIDEO BOOK
  static const endPointGetVideoBook = "WooEnglish/api/book/video-details";

  //PAGES
  static const endPointGetPages = "WooEnglish/api/get-pages";

  //READ AND LISTEN
  static const endPointGetReadListen = "WooEnglish/api/book-read-listen";

  //QUIZ
  static const endPointGetQuiz = "WooEnglish/api/book/quiz";
  static const endPointGetQuizReply = "WooEnglish/api/book/quiz-reply";
  static const endPointUserQuizBookWise = "WooEnglish/api/user/quiz-book-wise";
  static const endPointSubmitQuizAnswer = "${baseUrl}api/book/quiz-user-answers";

  //QUIZ DETAILS
  static const endStoreComment= "${baseUrl}api/store-comment";
  static const endGetComment= "WooEnglish/api/fetch-comments";

  //Dictionary
  static const endPointDictionaryApi= "https://api.dictionaryapi.dev/api/v2/entries/en/";

  //Remaining
  static const endPointGetBookStatus = "${baseUrl}api/book/get-any-view-book-status";

  //Read book
  static const endPointStoreFormatedData = "${baseUrl}api/store-formated-data";
  static const endPointUpdateFormatedData = "${baseUrl}api/update-formated-data";
  static const endPointGetFormatedData = "${baseUrl}api/fetch-formated-data";



}

class StatusCodeConstant {
  // Note: Only the widely used HTTP status codes are documented

  // Informational

  static int CONTINUE = 100;
  static int SWITCHING_PROTOCOLS = 101;
  static int PROCESSING = 102; // RFC2518

  // Success

  /*
   * The request has succeeded
   */
  static int OK = 200;

  /*
   * The server successfully created a new resource
   */
  static int CREATED = 201;
  static int ACCEPTED = 202;
  static int NON_AUTHORITATIVE_INFORMATION = 203;

  /*
   * The server successfully processed the request, though no content is returned
   */
  static int NO_CONTENT = 204;
  static int RESET_CONTENT = 205;
  static int PARTIAL_CONTENT = 206;
  static int MULTI_STATUS = 207; // RFC4918
  static int ALREADY_REPORTED = 208; // RFC5842
  static int IM_USED = 226; // RFC3229

  // Redirection

  static int MULTIPLE_CHOICES = 300;
  static int MOVED_PERMANENTLY = 301;
  static int FOUND = 302;
  static int SEE_OTHER = 303;

  /*
   * The resource has not been modified since the last request
   */
  static int NOT_MODIFIED = 304;
  static int USE_PROXY = 305;
  static int RESERVED = 306;
  static int TEMPORARY_REDIRECT = 307;
  static int PERMANENTLY_REDIRECT = 308; // RFC7238

  // Client Error

  /*
   * The request cannot be fulfilled due to multiple errors
   */
  static int BAD_REQUEST = 400;

  /*
   * The user is unauthorized to access the requested resource
   */
  static int UNAUTHORIZED = 401;
  static int PAYMENT_REQUIRED = 402;

  /*
   * The requested resource is unavailable at this present time
   */
  static int FORBIDDEN = 403;

  /*
   * The requested resource could not be found
   *
   * Note: This is sometimes used to mask if there was an UNAUTHORIZED (401) or
   * FORBIDDEN (403) error, for security reasons
   */
  static int NOT_FOUND = 404;

  /*
   * The request method is not supported by the following resource
   */
  static int METHOD_NOT_ALLOWED = 405;

  /*
   * The request was not acceptable
   */
  static int NOT_ACCEPTABLE = 406;
  static int PROXY_AUTHENTICATION_REQUIRED = 407;
  static int REQUEST_TIMEOUT = 408;

  /*
   * The request could not be completed due to a conflict with the current state
   * of the resource
   */
  static int CONFLICT = 409;
  static int GONE = 410;
  static int LENGTH_REQUIRED = 411;
  static int PRECONDITION_FAILED = 412;
  static int REQUEST_ENTITY_TOO_LARGE = 413;
  static int REQUEST_URI_TOO_LONG = 414;
  static int UNSUPPORTED_MEDIA_TYPE = 415;
  static int REQUESTED_RANGE_NOT_SATISFIABLE = 416;
  static int EXPECTATION_FAILED = 417;
  static int I_AM_A_TEAPOT = 418; // RFC2324
  static int UNPROCESSABLE_ENTITY = 422; // RFC4918
  static int LOCKED = 423; // RFC4918
  static int FAILED_DEPENDENCY = 424; // RFC4918
  static int RESERVED_FOR_WEBDAV_ADVANCED_COLLECTIONS_EXPIRED_PROPOSAL =
      425; // RFC2817
  static int UPGRADE_REQUIRED = 426; // RFC2817
  static int PRECONDITION_REQUIRED = 428; // RFC6585
  static int TOO_MANY_REQUESTS = 429; // RFC6585
  static int REQUEST_HEADER_FIELDS_TOO_LARGE = 431; // RFC6585

  // Server Error

  /*
   * The server encountered an unexpected error
   *
   * Note: This is a generic error message when no specific message
   * is suitable
   */
  static int INTERNAL_SERVER_ERROR = 500;

  /*
   * The server does not recognise the request method
   */
  static int NOT_IMPLEMENTED = 501;
  static int BAD_GATEWAY = 502;
  static int SERVICE_UNAVAILABLE = 503;
  static int GATEWAY_TIMEOUT = 504;
  static int VERSION_NOT_SUPPORTED = 505;
  static int VARIANT_ALSO_NEGOTIATES_EXPERIMENTAL = 506; // RFC2295
  static int INSUFFICIENT_STORAGE = 507; // RFC4918
  static int LOOP_DETECTED = 508; // RFC5842
  static int NOT_EXTENDED = 510; // RFC2774
  static int NETWORK_AUTHENTICATION_REQUIRED = 511;
}
