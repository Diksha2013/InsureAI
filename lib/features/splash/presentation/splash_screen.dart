import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navigationTimer;

  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color navy = Color(0xFF0F172A);

  @override
  void initState() {
    super.initState();

    _navigationTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.go('/onboarding');
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFEAF1FF)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxHeight < 500;

              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // InsureAI shield logo
                          Container(
                            width: isSmall ? 76 : 100,
                            height: isSmall ? 76 : 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF1FF),
                              borderRadius: BorderRadius.circular(
                                isSmall ? 22 : 28,
                              ),
                            ),
                            child: Icon(
                              Icons.shield_rounded,
                              size: isSmall ? 48 : 62,
                              color: primaryBlue,
                            ),
                          ),

                          SizedBox(height: isSmall ? 12 : 20),

                          // Brand name
                          Text.rich(
                            const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Insure',
                                  style: TextStyle(color: navy),
                                ),
                                TextSpan(
                                  text: 'AI',
                                  style: TextStyle(color: primaryBlue),
                                ),
                              ],
                            ),
                            style: TextStyle(
                              fontSize: isSmall ? 29 : 34,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1,
                            ),
                          ),

                          SizedBox(height: isSmall ? 8 : 12),

                          const Text(
                            'Insurance, made smarter.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF64748B),
                            ),
                          ),

                          SizedBox(height: isSmall ? 24 : 48),

                          const SizedBox(
                            width: 26,
                            height: 26,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: primaryBlue,
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            'Smart Insurance for a Safer Tomorrow',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
