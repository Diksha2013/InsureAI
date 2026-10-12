import 'package:flutter/material.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(const InsureAIApp());
}

class InsureAIApp extends StatelessWidget {
  const InsureAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'InsureAI',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
      ),
    );
  }
}
