class RoutePaths {
  // static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';

  static const String home = '/home';
  static const String search = '/search';

  static const String profile = '/profile';
  static const String personalInfo = '/profile/personal_info';
  static const String myResidence = '/profile/my_residence';
  static const String menuResidence = '/profile/my_residence/menu_residence/:id';
  static const String myResidenceDetail = '/profile/my_residence/menu_residence/:id/edit';
  static const String reservationHistory = '/profile/my_residence/menu_residence/:id/reservation_history';
  static const String reservationHistoryDetail = '/profile/my_residence/menu_residence/:id/reservation_history/:reservationId';
  static const String transaction = '/profile/my_residence/menu_residence/:id/transaction';
  static const String comments = '/profile/my_residence/menu_residence/:id/comments';

  static const String myBookings = '/my_bookings';
  static const String bookingDetails = '/my_bookings/details/:id';

  static const String bookmark = '/profile/bookmark';
  static const String chatList = '/profile/chat_list';
  static const String commentList = '/profile/comment_list';

  static const String residenceDetail = '/residence/:id';
  static const String requestToBook = '/residence/:id/request_to_book';
  static const String checkout = '/residence/:id/checkout';

  static const String requestToAddResidence = '/profile/request_to_add_residence';

  static const String chat = '/chat/:roomId';

  static const String paymentSuccess = '/payment-success';
  static const String paymentFailed = '/payment-failed';
  static const String verifyEmail = '/verify-email';
  static const String resetPassword = '/reset-password';
  static const String forgotPassword = '/forgot-password';
}
