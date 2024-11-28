import 'dart:io';

import 'package:flixid/presentation/pages/wallet_topup/wallet_topup.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/movie/movie.dart';
import '../../../domain/entities/movie_detail/movie_detail.dart';
import '../../../domain/entities/transaction/transaction.dart';
import '../../pages/booking_confirmation/booking_confirmation_page.dart';
import '../../pages/detail/detail_page.dart';
import '../../pages/login/login_page.dart';
import '../../pages/main/main_page.dart';
import '../../pages/register/register_page.dart';
import '../../pages/seat_booking/seat_booking_page.dart';
import '../../pages/time_booking/time_booking_page.dart';
import '../../pages/wallet/wallet_page.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
// ignore: deprecated_member_use_from_same_package, functional_ref
Raw<GoRouter> router(RouterRef ref) => GoRouter(routes: [
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => MainPage(
          imageFile: state.extra != null ? state.extra as File : null,
        ),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/detail',
        name: 'detail',
        builder: (context, state) => DetailPage(movie: state.extra as Movie),
      ),
      GoRoute(
        path: '/time-booking',
        name: 'time-booking',
        builder: (context, state) =>
            TimeBookingPage(movieDetail: state.extra as MovieDetail),
      ),
      GoRoute(
        path: '/seat-booking',
        name: 'seat-booking',
        builder: (context, state) => SeatBookingPage(
            transactionDetail: state.extra as (MovieDetail, Transaction)),
      ),
      GoRoute(
        path: '/booking-confirmation',
        name: 'booking-confirmation',
        builder: (context, state) => BookingConfirmationPage(
            transactionDetail: state.extra as (MovieDetail, Transaction)),
      ),
      GoRoute(
        path: '/wallet',
        name: 'wallet',
        builder: (context, state) => WalletPage(),
      ),
      GoRoute(
        path: '/wallet-topup',
        name: 'wallet-topup',
        builder: (context, state) => WalletTopup(),
      ),
    ], initialLocation: '/login', debugLogDiagnostics: false);
