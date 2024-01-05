import 'package:get/get.dart';
import '../modules/all_reviews/bindings/all_reviews_binding.dart';
import '../modules/all_reviews/views/all_reviews_view.dart';
import '../modules/app_setting/bindings/app_setting_binding.dart';
import '../modules/app_setting/views/app_setting_view.dart';
import '../modules/author/bindings/author_binding.dart';
import '../modules/author/views/author_view.dart';
import '../modules/author_list/bindings/author_list_binding.dart';
import '../modules/author_list/views/author_list_view.dart';
import '../modules/book_detail/bindings/book_detail_binding.dart';
import '../modules/book_detail/views/book_detail_view.dart';
import '../modules/book_list/bindings/book_list_binding.dart';
import '../modules/book_list/views/book_list_view.dart';
import '../modules/book_marks/bindings/book_marks_binding.dart';
import '../modules/book_marks/views/book_marks_view.dart';
import '../modules/congratulation/bindings/congratulation_binding.dart';
import '../modules/congratulation/views/congratulation_view.dart';
import '../modules/eBook/bindings/e_book_binding.dart';
import '../modules/eBook/views/e_book_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/favorites_books/bindings/favorites_books_binding.dart';
import '../modules/favorites_books/views/favorites_books_view.dart';
import '../modules/feedback/bindings/feedback_binding.dart';
import '../modules/feedback/views/feedback_view.dart';
import '../modules/finished_books/bindings/finished_books_binding.dart';
import '../modules/finished_books/views/finished_books_view.dart';
import '../modules/help_support/bindings/help_support_binding.dart';
import '../modules/help_support/views/help_support_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/my_books/bindings/my_books_binding.dart';
import '../modules/my_books/views/my_books_view.dart';
import '../modules/my_profile/bindings/my_profile_binding.dart';
import '../modules/my_profile/views/my_profile_view.dart';
import '../modules/my_subcription_plane/binding/my_subcription_plan_binding.dart';
import '../modules/navigator/bindings/navigator_binding.dart';
import '../modules/navigator/views/navigator_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/on_boarding/bindings/on_boarding_binding.dart';
import '../modules/on_boarding/views/on_boarding_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/quiz_detail/bindings/quiz_detail_binding.dart';
import '../modules/quiz_detail/views/quiz_detail_view.dart';
import '../modules/quizzes/bindings/quizzes_binding.dart';
import '../modules/quizzes/views/quizzes_view.dart';
import '../modules/read_book/bindings/read_book_binding.dart';
import '../modules/read_book/views/read_book_view.dart';
import '../modules/reviews/bindings/reviews_binding.dart';
import '../modules/reviews/views/reviews_view.dart';
import '../modules/search_screen/bindings/search_screen_binding.dart';
import '../modules/search_screen/views/search_screen_view.dart';
import '../modules/search_suggestion_list/bindings/search_suggestion_list_binding.dart';
import '../modules/search_suggestion_list/views/search_suggestion_list_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/subscription/bindings/subscription_binding.dart';
import '../modules/subscription/views/subscription_view.dart';
import '../modules/terms_condition/bindings/terms_condition_binding.dart';
import '../modules/terms_condition/views/terms_condition_view.dart';
import '../modules/verification/bindings/verification_binding.dart';
import '../modules/verification/views/verification_view.dart';
import '../modules/video_book/bindings/video_book_binding.dart';
import '../modules/video_book/views/video_book_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => const VerificationView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATOR,
      page: () => const NavigatorView(),
      binding: NavigatorBinding(),
    ),
    GetPage(
      name: _Paths.MY_BOOKS,
      page: () => const MyBooksView(),
      binding: MyBooksBinding(),
    ),
    GetPage(
      name: _Paths.MY_PROFILE,
      page: () => const MyProfileView(),
      binding: MyProfileBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_SCREEN,
      page: () => const SearchScreenView(),
      binding: SearchScreenBinding(),
    ),
    GetPage(
      name: _Paths.BOOK_LIST,
      page: () => BookListView(),
      binding: BookListBinding(),
    ),
    GetPage(
      name: _Paths.AUTHOR,
      page: () => const AuthorView(),
      binding: AuthorBinding(),
    ),
    GetPage(
      name: _Paths.AUTHOR_LIST,
      page: () => const AuthorListView(),
      binding: AuthorListBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_SUGGESTION_LIST,
      page: () => const SearchSuggestionListView(),
      binding: SearchSuggestionListBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.BOOK_MARKS,
      page: () => const BookMarksView(),
      binding: BookMarksBinding(),
    ),
    GetPage(
      name: _Paths.REVIEWS,
      page: () => const ReviewsView(),
      binding: ReviewsBinding(),
    ),
    GetPage(
      name: _Paths.E_BOOK,
      page: () => const EBookView(),
      binding: EBookBinding(),
    ),
    GetPage(
      name: _Paths.FINISHED_BOOKS,
      page: () => const FinishedBooksView(),
      binding: FinishedBooksBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITES_BOOKS,
      page: () => const FavoritesBooksView(),
      binding: FavoritesBooksBinding(),
    ),
    GetPage(
      name: _Paths.QUIZZES,
      page: () => const QuizzesView(),
      binding: QuizzesBinding(),
    ),
    GetPage(
      name: _Paths.APP_SETTING,
      page: () => const AppSettingView(),
      binding: AppSettingBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_CONDITION,
      page: () => const TermsConditionView(),
      binding: TermsConditionBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.HELP_SUPPORT,
      page: () => const HelpSupportView(),
      binding: HelpSupportBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION,
      page: () => SubscriptionView(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.BOOK_DETAIL,
      page: () => BookDetailView(),
      binding: BookDetailBinding(),
    ),
    GetPage(
      name: _Paths.READ_BOOK,
      page: () => ReadBookView(),
      binding: ReadBookBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_BOOK,
      page: () => VideoBookView(),
      binding: VideoBookBinding(),
    ),
    GetPage(
      name: _Paths.CONGRATULATION,
      page: () => const CongratulationView(),
      binding: CongratulationBinding(),
    ),
    GetPage(
      name: _Paths.ALL_REVIEWS,
      page: () => AllReviewsView(),
      binding: AllReviewsBinding(),
    ),
    GetPage(
      name: _Paths.FEEDBACK,
      page: () => FeedbackView(),
      binding: FeedbackBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ_DETAIL,
      page: () =>  QuizDetailView(),
      binding: QuizDetailBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];

}
