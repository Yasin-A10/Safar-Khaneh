import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safar_khaneh/core/network/secure_token_storage.dart';
import 'package:safar_khaneh/features/profile/presentation/chat_list_screen.dart';
import 'package:safar_khaneh/root/chat_screen.dart';
import 'package:safar_khaneh/trash/models/my_residence_model.dart';
import 'package:safar_khaneh/features/auth/presentation/forgot_password_screen.dart';
import 'package:safar_khaneh/features/auth/presentation/reset_password_screen.dart';
import 'package:safar_khaneh/features/deep_links/presentation/payment_failed_screen.dart';
import 'package:safar_khaneh/features/deep_links/presentation/payment_success_screen.dart';
import 'package:safar_khaneh/features/auth/presentation/verify_email_screen.dart';
import 'package:safar_khaneh/features/profile/data/my_booking_model.dart';
import 'package:safar_khaneh/features/profile/data/profile_model.dart';
import 'package:safar_khaneh/features/profile/data/transaction_model.dart';
import 'package:safar_khaneh/features/profile/data/vendor_reservation_model.dart';
import 'package:safar_khaneh/features/profile/presentation/bookmark_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/comments_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/edit_residence_detail_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/menu_residence.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/my_residences_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/reservation_history_detail.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/resevation_history_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/transaction_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/personal_info_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/request_to_add_residence/request_to_add_residence_screen.dart';
import 'package:safar_khaneh/features/residence/data/checkout_model.dart';
import 'package:safar_khaneh/features/residence/presentation/checkout_screen.dart';
import 'package:safar_khaneh/features/residence/presentation/request_to_book_screen.dart';
import 'package:safar_khaneh/features/search/data/residence_model.dart';
import 'package:safar_khaneh/root/not_found_screen.dart';
import 'route_paths.dart';
import 'package:safar_khaneh/features/profile/presentation/booking/booking_details_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/booking/my_bookings_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/profile_screen.dart';
import 'package:safar_khaneh/root/root_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/search/presentation/search_screen.dart';
import '../../features/residence/presentation/residence_detail_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// final List<String> publicRoutes = [
//   '/login',
//   '/register',
//   '/home',
//   '/search',
//   '/residence/:id'
//   '/forgot-password',
//   '/reset-password',
//   '/verify-email',
// ];

final List<RegExp> publicRoutePatterns = [
  RegExp(r'^/login$'),
  RegExp(r'^/register$'),
  RegExp(r'^/home$'),
  RegExp(r'^/search$'),
  RegExp(r'^/residence/\d+$'),
  RegExp(r'^/forgot-password$'),
  RegExp(r'^/reset-password$'),
  RegExp(r'^/verify-email$'),
];

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePaths.register,
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      path: RoutePaths.personalInfo,
      builder: (context, state) {
        final profile = state.extra as ProfileModel;
        return PersonalInfoScreen(profile: profile);
      },
    ),

    GoRoute(
      path: RoutePaths.residenceDetail,
      builder: (context, state) {
        final residence = state.extra as ResidenceModel;
        return ResidenceDetailScreen(residence: residence);
      },
    ),
    GoRoute(
      path: RoutePaths.requestToBook,
      builder: (context, state) {
        final residence = state.extra as ResidenceModel;
        return RequestToBookScreen(residence: residence);
      },
    ),
    GoRoute(
      path: RoutePaths.checkout,
      builder: (context, state) {
        final args = state.extra as CheckoutArguments;
        return CheckoutScreen(
          residence: args.residence,
          calculationResult: args.calculationResult,
        );
      },
    ),

    GoRoute(
      path: RoutePaths.menuResidence,
      builder: (context, state) {
        final contextModel = state.extra as ResidenceContextModel;
        return MenuResidence(contextModel: contextModel);
      },
    ),

    GoRoute(
      path: RoutePaths.bookingDetails,
      builder: (context, state) {
        final reservation = state.extra as UserReservationModel;
        return BookingDetailsScreen(reservation: reservation);
      },
    ),
    GoRoute(
      path: RoutePaths.myResidence,
      builder: (context, state) => const MyResidenceScreen(),
    ),
    GoRoute(
      path: RoutePaths.myResidenceDetail,
      builder: (context, state) {
        final residence = state.extra as ResidenceModel;
        return EditResidenceDetailScreen(residence: residence);
      },
    ),

    GoRoute(
      path: RoutePaths.reservationHistory,
      builder: (context, state) {
        final contextModel = state.extra as ResidenceContextModel;
        return ReservationHistoryScreen(contextModel: contextModel);
      },
    ),
    GoRoute(
      path: RoutePaths.reservationHistoryDetail,
      builder: (context, state) {
        final vendorReservation = state.extra as VendorReservationModel;
        return ReservationHistoryDetailScreen(
          vendorReservation: vendorReservation,
        );
      },
    ),

    GoRoute(
      path: RoutePaths.transaction,
      builder: (context, state) {
        final contextModel = state.extra as ResidenceContextModel;
        return TransactionScreen(contextModel: contextModel);
      },
    ),

    GoRoute(
      path: RoutePaths.comments,
      builder: (context, state) {
        final residence = state.extra as MyResidenceModel;
        return CommentsScreen(residence: residence);
      },
    ),

    GoRoute(
      path: RoutePaths.bookmark,
      builder: (context, state) => const BookmarkScreen(),
    ),

    GoRoute(
      path: RoutePaths.chatList,
      builder: (context, state) => const ChatListScreen(),
    ),

    GoRoute(
      path: RoutePaths.requestToAddResidence,
      builder: (context, state) => const RequestToAddResidenceScreen(),
    ),

    GoRoute(
      path: RoutePaths.chat,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return ChatScreen(
          roomId: data['roomId'],
          receiverName: data['receiverName'],
          currentUserId: data['currentUserId'],
        );
      },
    ),

    GoRoute(
      path: RoutePaths.paymentSuccess,
      builder: (context, state) => const PaymentSuccessScreen(),
    ),
    GoRoute(
      path: RoutePaths.paymentFailed,
      builder: (context, state) => const PaymentFailedScreen(),
    ),
    GoRoute(
      path: RoutePaths.verifyEmail,
      builder: (context, state) => const VerifyEmailScreen(),
    ),
    GoRoute(
      path: RoutePaths.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: RoutePaths.resetPassword,
      builder: (context, state) => const ResetPasswordScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) => RootScreen(child: child),
      routes: [
        GoRoute(
          path: RoutePaths.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RoutePaths.myBookings,
          builder: (context, state) => const MyBookingsScreen(),
        ),
        GoRoute(
          path: RoutePaths.search,
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: RoutePaths.profile,
          builder: (context, state) => ProfileScreen(),
        ),
      ],
    ),
  ],

  // redirect: (context, state) async {
  //   final isLoggedIn = await TokenStorage.hasAccessToken();
  //   final isPublicRoute = publicRoutes.contains(state.matchedLocation);

  //   if (!isLoggedIn && !isPublicRoute) return '/login';
  //   if (isLoggedIn && state.matchedLocation == '/login') return '/login';
  //   return null;
  // },
  redirect: (context, state) async {
    final isLoggedIn = await TokenStorage.hasAccessToken();
    final currentPath = state.matchedLocation;

    final isPublicRoute = publicRoutePatterns.any(
      (pattern) => pattern.hasMatch(currentPath),
    );

    if (!isLoggedIn && !isPublicRoute) return '/login';
    if (isLoggedIn && currentPath == '/login') return '/home';
    return null;
  },

  errorBuilder: (context, state) => const NotFoundScreen(),
);

class CheckoutArguments {
  final ResidenceModel residence;
  final CheckoutPriceModel calculationResult;

  CheckoutArguments({required this.residence, required this.calculationResult});
}

class ResidenceContextModel {
  final ResidenceModel residence;
  final VendorReservationModel? reservations;
  final PayoutModel? payout;
  // final TransactionModel? transactions;
  // final CommentModel? comments;

  ResidenceContextModel({
    required this.residence,
    this.reservations,
    this.payout,
    // required this.transactions,
    // this.comments,
  });
}
