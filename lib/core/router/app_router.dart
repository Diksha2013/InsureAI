import 'package:go_router/go_router.dart';
import 'package:insure_ai/features/dashboard/presentation/emi_calculator_screen.dart';
import 'package:insure_ai/features/dashboard/presentation/health_insurance_screen.dart';

import '../../features/splash/presentation/splash_screen.dart';
import '../../features/splash/presentation/onboarding_screen.dart';
import '../../features/splash/presentation/login_screen.dart';
import 'package:insure_ai/features/splash/presentation/register_screen.dart';
import 'package:insure_ai/features/dashboard/presentation/dashboard_screen.dart';

import 'package:insure_ai/features/dashboard/presentation/ai_chat_screen.dart';
import 'package:insure_ai/features/dashboard/presentation/ai_recommendation_results_screen.dart';
import 'package:insure_ai/features/dashboard/presentation/vehicle_insurance_screen.dart';

import 'package:insure_ai/features/dashboard/presentation/health_insurance_screen.dart';
import 'package:insure_ai/features/dashboard/presentation/emi_calculator_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
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
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(path: '/', builder: (context, state) => const DashboardScreen()),

    GoRoute(
      path: '/ai-chat',
      builder: (context, state) => const AiChatScreen(),
    ),
    GoRoute(
      path: '/ai-results',
      builder: (context, state) => const AiRecommendationResultsScreen(),
    ),
    GoRoute(
      path: '/vehicle-insurance',
      builder: (context, state) => const VehicleInsuranceScreen(),
    ),

    GoRoute(
      path: '/health-insurance',
      builder: (context, state) => const HealthInsuranceScreen(),
    ),
    GoRoute(
      path: '/emi-calculator',
      builder: (context, state) => const EmiCalculatorScreen(),
    ),
  ],
);
