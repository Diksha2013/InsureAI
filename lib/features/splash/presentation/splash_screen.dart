import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  static const Color blue = Color(0xFF315FE9);
  static const Color navy = Color(0xFF142B4A);

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFFF7F9FE),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _scale = Tween<double>(
      begin: 0.82,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    _timer = Timer(const Duration(milliseconds: 2400), () {
      if (!mounted) return;
      context.go('/login_screen');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FE),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xFFF3F6FF), Color(0xFFEAF0FF)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxHeight < 650;

              return FadeTransition(
                opacity: _fade,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),

                        // Animated brand mark
                        ScaleTransition(
                          scale: _scale,
                          child: Container(
                            width: compact ? 86 : 104,
                            height: compact ? 86 : 104,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF4778FF), Color(0xFF244FD1)],
                              ),
                              borderRadius: BorderRadius.circular(
                                compact ? 25 : 30,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: blue.withOpacity(0.23),
                                  blurRadius: 28,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.shield_rounded,
                              size: compact ? 49 : 60,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        SizedBox(height: compact ? 22 : 28),

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
                                style: TextStyle(color: blue),
                              ),
                            ],
                          ),
                          style: TextStyle(
                            fontSize: compact ? 34 : 39,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1.5,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Insurance, made smarter.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF68778F),
                            letterSpacing: 0.1,
                          ),
                        ),

                        SizedBox(height: compact ? 28 : 38),

                        // Subtle loading indicator
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: blue,
                            backgroundColor: const Color(0xFFDDE6FF),
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          'Preparing your experience',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8490A4),
                          ),
                        ),

                        const Spacer(),

                        // Bottom brand message
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_user_outlined,
                              size: 16,
                              color: blue.withOpacity(0.8),
                            ),
                            const SizedBox(width: 7),
                            const Text(
                              'Your protection, all in one place',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF68778F),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                      ],
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
