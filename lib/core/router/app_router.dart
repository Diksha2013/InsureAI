import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/splash_screen.dart';
import '../../features/splash/presentation/onboarding_screen.dart';
import '../../features/splash/presentation/login_screen.dart';
import '../../features/splash/presentation/register_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import 'auth_refresh_notifier.dart';

final AuthRefreshNotifier _authRefreshNotifier = AuthRefreshNotifier();

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: _authRefreshNotifier,
  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;
    final location = state.matchedLocation;

    final isLogin = location == '/login';
    final isSignup = location == '/signup';
    final isOnboarding = location == '/onboarding';
    final isDashboard = location == '/dashboard';

    // Protect the dashboard.
    if (user == null && isDashboard) {
      return '/login';
    }

    // Signed-in users should not see login/signup again.
    if (user != null && (isLogin || isSignup || isOnboarding)) {
      return '/dashboard';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);
