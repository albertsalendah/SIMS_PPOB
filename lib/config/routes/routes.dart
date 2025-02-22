import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/core/di/init_dependencies.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/presentation/pages/login_page.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/presentation/provider/auth_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/nav_bar.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/menu.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/presentation/pages/payment_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import 'routes_name.dart';

GoRouter router(BuildContext context) {
  return GoRouter(
    initialLocation: "/login_page",
    refreshListenable: navigationRefreshNotifier,
    errorBuilder: (context, state) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text(state.error.toString())),
          ],
        ),
      );
    },
    redirect: (context, state) {
      final authProvider = context.read<AuthProvider>();
      final token = authProvider.getToken();
      final isTokenExpired =
          token != null ? authProvider.isTokenExpired(token) : true;
      final isLoggedIn = token != null && !isTokenExpired;

      if (!isLoggedIn &&
          state.matchedLocation != '/${RoutesName.login}' &&
          state.matchedLocation != '/${RoutesName.signup}') {
        return '/${RoutesName.login}';
      }

      if (isLoggedIn && state.matchedLocation == '/${RoutesName.login}') {
        return '/${RoutesName.navBar}';
      }

      return null;
    },
    routes: [
      GoRoute(
          path: "/${RoutesName.login}",
          name: RoutesName.login,
          builder: (context, state) {
            return const LoginPage();
          },
          routes: const []),
      GoRoute(
          path: "/${RoutesName.signup}",
          name: RoutesName.signup,
          builder: (context, state) {
            return const SignupPage();
          },
          routes: const []),
      GoRoute(
          path: "/${RoutesName.navBar}",
          name: RoutesName.navBar,
          builder: (context, state) {
            return const NavBar();
          },
          routes: []),
      GoRoute(
          path: "/${RoutesName.paymentPage}",
          name: RoutesName.paymentPage,
          builder: (context, state) {
            return PaymentPage(selectedService: state.extra as Menus);
          },
          routes: const []),
    ],
  );
}
