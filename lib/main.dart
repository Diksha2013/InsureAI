import 'package:flutter/material.dart';
import 'package:insure_ai/features/dashboard/presentation/ai_chat_screen.dart';
import 'package:insure_ai/features/dashboard/presentation/ai_recommendation_results_screen.dart';
import 'package:insure_ai/features/dashboard/presentation/emi_calculator_screen.dart';
import 'package:insure_ai/features/dashboard/presentation/vehicle_insurance_screen.dart';

import 'package:insure_ai/features/dashboard/presentation/dashboard_screen.dart';
import 'package:insure_ai/features/splash/presentation/login_screen.dart';
import 'package:insure_ai/features/splash/presentation/onboarding_screen.dart';
import 'package:insure_ai/features/splash/presentation/splash_screen.dart';
import 'core/router/app_router.dart';
import 'package:insure_ai/features/dashboard/presentation/health_insurance_screen.dart';

void main() {
  runApp(const InsureAIApp());
}

class InsureAIApp extends StatelessWidget {
  const InsureAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: OnboardingScreen());
  }
}
