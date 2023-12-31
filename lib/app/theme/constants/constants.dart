import 'package:flutter/cupertino.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class C {
  /*     font family name   */
  static const fontAlegreya = "Alegreya";
  static const fontInter = "Inter";
  static const fontOpenSans = "OpenSans";
  static const fontPlayfairDisplay = "PlayfairDisplay";
  static const fontLato = "Lato";

  /*   AutoValidate mode   */
  static const autoValidateMode = AutovalidateMode.disabled;

  /*       margins     */
  static double margin = 16.px;
  static double buttonRadius = 25.px;
  static double iconButtonRadius = 25.px;
  static double textButtonRadius = 10.px;
  static double loginTextFieldRadius = 10.px;
  static var wooEnglishAppLogoMargin = 60.px;


  /*Firebase key constant*/
  static const routes =  "routes";
  static const authorId =  "author_id";
  static const bookId =  "book_id";
  static const categoryId =  "category_id";
  static const chapterId =  "chapter_id";

  static const authors =  "authors";
  static const books =  "books";
  static const chapters =  "chapters";
  static const video =  "video";

  static const not =  "Not";
  static const yes =  "Yes";




  /*      OnBoarding | Login | SignUp | Verification Module      */

  ///OnBoarding
  static const imageSplashScreenBackground =
      "assets/images/splash_screen_background.png";
  static const imageOnBoardingOne = "assets/images/on_boarding_one.png";
  static const imageOnBoardingTwo = "assets/images/on_boarding_two.png";
  static const imageOnBoardingThree = "assets/images/on_boarding_three.png";
  static const textOnBoardingOneTitle = "Welcome to read time";
  static const textOnBoardingTwoTitle = "Choose you book";
  static const textOnBoardingThreeTitle = "Read you book anytime";
  static const textOnBoardingDescription =
      "Lorem ipsum dolor sit amet consectetur. Libero scelerisque leo ullamcorper cursus ultricies nunc elit volutpat vitae. Ornare venenatis sit interdum purus ipsum facilisi.";
  static const textSkip = "Skip";
  static const textNext = "Next";

  ///SignIn
  static const imageFacebookLogo = "assets/images/facebook_logo.png";
  static const imageGoogleLogo = "assets/images/google_logo.png";
  static const imageWooEnglishAppLogo = "assets/images/woo_english_app_logo.png";
  static const textHelloAgain = "Hello again!";
  static const textWelcomeBack = "Welcome back";
  static const textMobileNumber = "Mobile Number";
  static const textEnterNumber = "Enter your mobile number ";
  static const textGetOtp = "GET OTP";
  static const textContinueWith = "Or continue with";
  static const textDontHaveAccount = "Don’t have an Account?";
  static const textSignUp = "SIGN UP";

  ///SignUp
  static const textHello = "Hello!";
  static const textToGetStarted = "Signup to get started";
  static const textName = "Name";
  static const textEnterName = "Enter your name";
  static const textEmail = "Email Address";
  static const textEnterEmail = "Enter your email address";
  static const textSignIn = "SIGN IN";
  static const textAlreadyHave = "Already have an Account?";

  ///Verification
  static const textEnterOtp = "Enter OTP";
  static const textConfirmation =
      "Confirmation Code has been sent to your mobile no. ";
  static const textNotGetOtp = "Not get OTP? ";
  static const textResendOtp = "Resend OTP";
  static const textVerify = "Verify";

  /*       Navigator | Home | Search | MyBooks |Profile     */

  /// Navigator
  static const imageBottomBarFavorite =
      "assets/images/bottombar_favorite_logo.png";
  static const imageBottomBarUserLogo = "assets/images/bottombar_user_logo.png";
  static const imageBottomBarHomeLogo = "assets/images/bottombar_home_logo.png";
  static const imageBottomBarSearchLogo =
      "assets/images/bottombar_search_logo.png";

  /// Home
  static const imageNotificationLogo = "assets/images/notification_logo.png";
  static const imageBookImage = "assets/images/book_image.png";
  static const imageBookLikeLogo = "assets/images/book_like_logo.png";
  static const imageSoundLogo = "assets/images/sound_logo.png";
  static const imagePlayLogo = "assets/images/play_logo.png";
  static const imageStarLogo = "assets/images/star_logo.png";
  static const imageEyeLogo = "assets/images/eye_logo.png";
  static const imageFilterAudioLogo = "assets/images/filter_sound.png";
  static const imageFilterMuteLogo = "assets/images/filter_mute.png";
  static const textHome = "Home";
  static const textItsTimeToRead = 'It’s time to read!';
  static const textContinueReading = "Continue Reading";
  static const textBookName = 'The Book Of Unseen Words';
  static const textChapter = 'Chapter';
  static const textMostPopularBooks = "Most Popular Books";
  static const textRecommendedForYou = "Recommended For you";
  static const textYourFavorite = "Your favorite";
  static const textNewRelease = "New Release";
  static const textMemberOnlyBooks = "Members - Only Books ";
  static const textFamousAuthors = "Famous Authors";
  static const textAuthorName = "J.K. Rowling";
  static const textSeeMore = "See More";

  /// Search
  static const imageSearchPageLogo = "assets/images/search_page_logo.png";
  static const imageFilterLogo = "assets/images/filter_logo.png";
  static const imageSuggestionArrowLogo = "assets/images/suggestion_arrow_logo.png";
  static const textSearch = "Search";
  static const textTopBooks = 'Top Books For You';
  static const textBrowserAll = 'Browser All';
  static const textFilter = "Filter";
  static const textClearFilter= "Clear Filter";
  static const textApplyFilter= "Apply Filter";
  static const textLanguage = "Language:";
  static const textWhatYouWant = "What You Want";
  static const textCategories = "Categories";
  static const textEnglishAssent = "English Accent";
  static const textLevel = "Level";
  static const textLength = "Length";

  ///MyBooks
  static const textMyBooks = "My Books";

  ///MyProfile
  static const imageGetPremium = "assets/images/get_premium.png";
  static const imageArrowForwordLogo = "assets/images/arrow_forword_logo.png";
  static const textMyProfile = "My Profile";
  static const textUserName = "Maria John";
  static const textWooEnglishOfficial= "Woo English Official";
  static const textEditProfile = "Edit Profile";
  static const textOnGoing = "Ongoing";
  static const textCompleted = "Completed";
  static const textMyCollection = "My Collection";
  static const textGetPremium = "Get  Premium";
  static const textDownloadNowAnd =
      "Download now and listen or watch your book offline";
  static const textMyBookMark = "My Bookmark";
  static const textMyReview = "My Reviews";
  static const textMyeBooks = "My eBooks";
  static const textMyFavorites = "My Favourite";
  static const textMyFinishedBooks = "My Finished Books";
  static const textMyQuizzes = "My Quizzes";
  static const textAppSettings = "App Settings";
  static const textTermAndCondition = "Terms & Condition";
  static const textPrivacyPolicy = "Privacy Policy";
  static const textPrivacyPolicyDis =
      '''Lorem ipsum dolor sit amet interdum. Leo ut posuere mauris amet amet nibh fames posuere. Amet nec sociis ornare commodo nascetur eu vitae proin. Mauris neque    posuere. Amet nec sociis ornare  commodo nascetur eu vitae proin. Mauris  neque enim elementum vel nullam nunc laoreet elementum.\n''';
  static const textHelpAndSupport = "Help & Support";
  static const textLogout = "Logout";

  /*EditProfile | Subscription | Payment | Congratulations | MyBookMark | MyReviews | MyeBooks | MyFavorites | MyFinished |
    MyQuiz | AppSetting | TermsAndCondition | Privacy Policy | Help And Support*/

  ///EditProfile
  static const imageUserProfile = "assets/images/user_profile.png";
  static const imageAuthorProfile = "assets/images/author_profile.png";
  static const imageChangeImageLogo = "assets/images/change_image_logo.png";
  static const textEnterPhoneNumber = "Enter Phone number";
  static const textUserNumber = "+91 900099009";
  static const textEnterEmailAddress = "Enter Email Address";
  static const textUserEmail = "maria@xyz.com";
  static const textUpdateProfile = "Update Profile";
  static const textSelectImage = "Select Image";
  static const textTakePhoto = "Take Photo";
  static const textChooseFromLibrary = "Choose From Library";
  static const textRemovePhoto = "Remove Photo";
  static const textCancel = "Cancel";

  ///Subscription
  static const textSubscription = "Subscription";
  static const textGetAccessToAllBooksAndFeatures =
      "Get access to all books and features";
  static const textSubscriptionDis =
      "Lorem ipsum dolor sit amet consectetur. Scelerisque integer ac consectetur Audio.  ";
  static const textWhatIncludedInSubscription =
      "What included in subscription plan";
  static const textWhatIncludedInSubscriptionDis =
      "Lorem ipsum dolor sit amet consjehfjjj.";
  static const textFreeTrial = "FREE TRIAL";
  static const textPerMonthRupee = "/month";
  static const textThenPerMonthRupee = "Then \$99 per month";
  static const textMonthly = "Monthly";
  static const textPerMonthRupeeSelected = "\$119.8/month";
  static const textThenPerMonthRupeeSelected = "Then \$9.99 per month";
  static const textSubscriptionNow = "Subscription Now";

  ///Payment
  static const imageVisaLogo = "assets/images/visa_logo.png";
  static const imagePayPalLogo = "assets/images/paypal_logo.png";
  static const imageMasterCardLogo = "assets/images/master_card_logo.png";
  static const imageMasterCard = "assets/images/master_card_image.png";
  static const textPayment = "Payment";
  static const textCardDetails = "Card Details:";
  static const textNameONCard = "Name On Card ";
  static const textEnterCardHolderName = "Enter Card Holder Name";
  static const textCardNumber = "Card Number";
  static const textEnterYourCardNumber = "Enter Your Card Number";
  static const textExpiryDate = "Expiry Date";
  static const textCVV = "CVV";
  static const textCVVCode = "CVV Code";

  ///Congratulations
  static const imageCompleteLogo = "assets/images/complete_logo.png";
  static const textCongratulation = "Congratulation!";
  static const textYourPayment = "Your payment has been process successfully.";
  static const textNowYouCanListen =
      "Now you can listen audio and watch offline.";
  static const textBackToHome = "Back to Home";

  ///MyBookMark
  static const imageArrowForwordDark =
      "assets/images/arrow_forword_logo_dark.png";
  static const imageBookmarkTitle = "assets/images/bookmark_title_image.png";

  ///MyQuiz
  static const imageQuizLogo = "assets/images/quiz_logo.png";

  ///AppSetting
  static const textNotification = "Notification";
  static const textNotificationDis = "Lorem ipsum dolor sit amet consectetur.";
  static const textDarkMode = "Reading Dark Mode";
  static const textDarkModeDis = "Lorem ipsum dolor sit amet consectetur.";
  static const textApplicationUpdate = "Application Update";
  static const textApplicationUpdateDis =
      "Lorem ipsum dolor sit amet consectetur.";

  ///PrivacyPolicy
  static const textIntroduction = "Introduction:";
  static const textManageInfo = "Managing Your Information";

  ///TermsAndCondition
  static String textTermsAndConditionDis =
      '''Lorem ipsum dolor sit amet consectetur. Tincidunt mi justo eget ac amet lacus dolor cursus in. Aliquam condimentum consequat ut consectetur. Sapien interdum pulvinarenim tincidunt sit. Ut laoreet amet nec elementum vel proin facilisi pellentesque. Duis sit sit turpis ornare euismod elementum leo sapien. Et risus tempor eget donec. Arcu commodo fringilla facilisi nunc egestas. Leo ut posuere mauris amet amet nibh fames posuere. Amet nec sociis ornare commodo nascetur eu vitae proin. Mauris neque enim elementum vel nullam nunc laoreet elementum.\n\nLorem ipsum dolor sit amet consectetur. Tincidunt mi justo eget ac amet lacus dolor cursus in. Aliquam condimentum consequat ut consectetur. Sapien interdum pulvinar enim tincidunt sit. Ut laoreet  amet nec elementum vel proin facilisi pellentesque. Duis sit   sit turpis ornare euismod elementum leo sapien. Et risus   tempor eget donec. Arcu commodo fringilla facilisi nunc   egestas. Leo ut posuere mauris amet amet nibh fames   posuere. Amet nec sociis ornare do fringilla facilisi nunc   egestas. Leo ut posuere mauris amet amet nibh fames   posuere. Amet nec sociis ornare do fringilla facilisi nunc   egestas. Leo ut posuere mauris amet amet nibh fames   posuere. Amet nec sociis ornare do fringilla facilisi nunc   egestas. Leo ut posuere mauris amet amet nibh fames   posuere. Amet nec sociis ornare do fringilla facilisi nunc   egestas. Leo ut posuere mauris amet amet nibh fames   posuere. Amet nec sociis ornare do fringilla facilisi nunc   egestas. Leo ut posuere mauris amet amet nibh fames   posuere. Amet nec sociis ornare do fringilla facilisi nunc   egestas. Leo ut posuere mauris amet amet nibh fames   posuere. Amet nec sociis ornare  commodo nascetur eu vitae proin. Mauris  neque enim elementum vel nullam nunc laoreet elementum.''';

  ///HelpAndSupport
  static const imageHelpAndSupport = "assets/images/help_support.png";
  static const imagePhoneLogo = "assets/images/phone_logo.png";
  static const imageMessageLogo = "assets/images/message_logo.png";
  static const textHowCanWeHelpYou = "How can we help you?";
  static const textSupportNumber = "90009-90009";
  static const textSupportEmail = "xyz@gmail.com";
  static const textWriteUs = "Write Us";
  static const textWriteYourMessage = "Write your message here........";
  static const textWriteYourReview = "Write your review here........";
  static const textSubmit = "Submit";

  /* Author Profile | Notification |See More Books*/

  ///AuthorProfile
  static const textAuthorCountry = "British author";
  static const textBooks = "Books";
  static const textFollowers = "Followers";
  static const textFollow = "Follow";
  static const textUnFollow = "UnFollow";
  static const textReviews = "Reviews";
  static const textReviewDis =
      "Lorem ipsum dolor sit amet consectetur. Molestie Lorem ipsum dolor sit amet consectetur. Molestie eu vulputate donec tellus diam laoreet sagittis. Urna habitant ac et elementum.Read More";
  static const textReadMore = "Read More";
  static const textReadLess = "Read Less";

  ///Notification
  static const imageCrossLogo = "assets/images/cross_logo.png";
  static const textNotifications = "Notifications";
  static const textClearAll = "Clear all";
  static const textNotificationTitle = "Active Plan";
  static const textNotificationSubtitle =
      "Lorem ipsum dolor sit amet consectetur.";

  /* Book Detail | Read And Listen | Video*/

  ///BookDetail
  static const imageInfoLogo = "assets/images/info_logo.png";
  static const imageDownloadLogo = "assets/images/download_logo.png";
  static const imageThreeDotExtraLogo = "assets/images/three_dot_extra.png";
  static const imageThreeLineLogo = "assets/images/three_line.png";
  static const imageHartLogoBookDetails =
      "assets/images/hart_logo_bookdetails.png";
  static const imageTimeLogo = "assets/images/time_logo.png";
  static const textTotalWords = "Total Words:";
  static const textLevelBokDetails = "Level: ";
  static const textGenre = "Genre: ";
  static const textAccent = "Accent: ";
  static const textOverview = "Overview:";
  static const textOverViewDis =
      "The tradition of British aristocrats is more than a thousand years old. tradition of British aristocrats is moretradition of British aristocrats is more than a thousand years old. The royal family keeps a large number of ancient traditions. In fact, they themselves are part of the history. But besides, the members of the royal family are also real people with their own stories and problems. Read More";
  static const textAd = "Here will you admob ad shown";
  static const textSimilarBooks = "Similar Books";
  static String textReadAndListen = "Read & Listen";
  static String textVideo = "Video";

  ///ReadAndListen
  static const imagePopUpIconOne = "assets/images/popup_menu_icon_one.png";
  static const imagePopUpIconTwo = "assets/images/popup_menu_icon_two.png";
  static const imagePopUpIconThree = "assets/images/popup_menu_icon_three.png";
  static const imagePopUpIconFour= "assets/images/popup_menu_icon_four.png";
  static const imagePopUpIconFive = "assets/images/popup_menu_icon_five.png";
  static const imagePopUpIconSix = "assets/images/popup_menu_icon_six.png";
  static const imagePopUpIconSeven = "assets/images/popup_menu_icon_seven.png";
  static const imagePopUpIconEight = "assets/images/popup_menu_icon_eight.png";
  static const imagePopUpIconNine = "assets/images/popup_menu_icon_nine.png";
  static const imagePopUpIconDown = "assets/images/popup_menu_icon_down.png";

  static const imageZoomLogo = "assets/images/zoom_logo.png";
  static const imageZoomInLogo = "assets/images/zoom_in_logo.png";
  static const imageComaLogo = "assets/images/comma_logo.png";
  static const imageArrowUpKeyBoardLogo = "assets/images/arrow_up_keyboard.png";
  static const imageArrowDownKeyBoardLogo =
      "assets/images/arrow_down_keyboard.png";
  static const imagePlayMusicLogo = "assets/images/play_audio_logo.png";
  static const imagePlayBackLogo = "assets/images/playback_logo.png";
  static const imagePlayForwordLogo = "assets/images/playforward_logo.png";
  static const imageEyeHideLogo = "assets/images/eye_hide_logo.png";
  static const imageMusicSoundLogo = "assets/images/music_sound_logo.png";
  static const imageMusicSoundMusicHideLogo =
      "assets/images/sound_logo_music_hide_logo.png";
  static String imageEyeShowLogo = "assets/images/eye_show_logo.png";
  static var textReply = "Reply";
  static String textComments = "Comments";


  ///FEEDBACK
  static String imageFeedBackScreen = "assets/images/feedback_screen.png";
  static String textFeedBack = "Feedback";
  static String textFeedBackDis = "I'm here to help!\nHow can I assist you?";


  ///COMMON IMAGES AND STRINGS
  static String imageBackButton = "assets/images/back_button_icon.png";
  static String imageSomethingWentWrong = "assets/images/something_went_wrong.png";
  static String imageNoDataFound = "assets/images/no_data_found.png";
  static String imageNoInternetConnection = "assets/images/no_internet_image.png";

  static String textNoInternetTitle = "Oops....";
  static String textNoInternetDis = "There is a connection error. Please check your internet and try again.";
  static String textNoDataTitle = "Oops.... No result found.";
  static String textNoDataDis = "We couldn’t found what you searched for.Try searching again.";
  static String textSomethingWentWrongTitle = "Ohh.. No something went wrong";
  static String textSomethingWentWrongDis = "We are working on fixing the problem. Please refresh the page and try again.";

  static String textDefaultCountryCode='+91';

}
