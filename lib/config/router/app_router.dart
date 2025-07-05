import 'package:go_router/go_router.dart';
import 'package:safar_khaneh/data/models/booked_residence_model.dart';
import 'package:safar_khaneh/data/models/my_residence_model.dart';
import 'package:safar_khaneh/data/models/vendor_reservation_model.dart';
import 'package:safar_khaneh/features/profile/presentation/bookmark_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/comments_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/edit_residence_detail_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/menu_residence.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/my_residences_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/reservation_history_detail.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/resevation_history_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/my_residences/transation_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/personal_info_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/request_to_add_residence/request_to_add_residence_screen.dart';
import 'package:safar_khaneh/features/residence/presentation/checkout_screen.dart';
import 'package:safar_khaneh/features/residence/presentation/request_to_book_screen.dart';
import 'package:safar_khaneh/features/search/data/residence_model.dart';
import 'package:safar_khaneh/root/not_found_screen.dart';
import 'route_paths.dart';
import 'package:safar_khaneh/features/profile/presentation/booking/booking_details_screen.dart';
import 'package:safar_khaneh/data/models/residence_card_model.dart';
import 'package:safar_khaneh/features/profile/presentation/booking/my_bookings_screen.dart';
import 'package:safar_khaneh/features/profile/presentation/profile_screen.dart';
import 'package:safar_khaneh/root/root_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/search/presentation/search_screen.dart';
import '../../features/residence/presentation/residence_detail_screen.dart';

final GoRouter appRouter = GoRouter(
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
      builder: (context, state) => const PersonalInfoScreen(),
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
        final residence = state.extra as ResidenceCardModel;
        return RequestToBookScreen(residence: residence);
      },
    ),
    GoRoute(
      path: RoutePaths.checkout,
      builder: (context, state) {
        final residence = state.extra as ResidenceCardModel;
        return CheckoutScreen(residence: residence);
      },
    ),

    GoRoute(
      path: RoutePaths.menuResidence,
      builder: (context, state) {
        final residence = state.extra as MyResidenceModel;
        return MenuResidence(residence: residence);
      },
    ),

    GoRoute(
      path: RoutePaths.bookingDetails,
      builder: (context, state) {
        final residence = state.extra as BookedResidenceModel;
        return BookingDetailsScreen(residence: residence);
      },
    ),
    GoRoute(
      path: RoutePaths.myResidence,
      builder: (context, state) => const MyResidenceScreen(),
    ),
    GoRoute(
      path: RoutePaths.myResidenceDetail,
      builder: (context, state) {
        final residence = state.extra as MyResidenceModel;
        return EditResidenceDetailScreen(residence: residence);
      },
    ),

    GoRoute(
      path: RoutePaths.reservationHistory,
      builder: (context, state) {
        final residence = state.extra as MyResidenceModel;
        return ReservationHistoryScreen(residence: residence);
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
      builder: (context, state) => const TransactionScreen(),
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
      path: RoutePaths.requestToAddResidence,
      builder: (context, state) => const RequestToAddResidenceScreen(),
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
  errorBuilder: (context, state) => const NotFoundScreen(),
);
