import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const Color blue = Color(0xFF2563EB);
  static const Color navy = Color(0xFF0F172A);
  static const Color grey = Color(0xFF64748B);
  static const Color lightBlue = Color(0xFFEAF1FF);

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      title: 'One App for Your\nComplete Protection',
      description:
          'Manage all your insurance, EMIs and get personalized recommendations with the power of AI.',
      icon: Icons.shield_rounded,
      color: blue,
      caption: 'Your protection, simplified',
    ),
    _OnboardingData(
      title: 'Welcome to\nSmarter Insurance',
      description:
          'Manage vehicle, health and hospital insurance policies in one convenient place.',
      icon: Icons.health_and_safety_rounded,
      color: Color(0xFF0D9488),
      caption: 'Everything in one place',
    ),
    _OnboardingData(
      title: 'Insurance Powered\nby AI',
      description:
          'Find suitable insurance options based on your coverage needs and budget.',
      icon: Icons.auto_awesome_rounded,
      color: Color(0xFF7C3AED),
      caption: 'Personalized for you',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            final isShort = screenHeight < 700;

            // Give the page content a bounded height. If the entire
            // screen is too short, the outer view can scroll.
            final pageHeight = (screenHeight - (isShort ? 175.0 : 205.0)).clamp(
              360.0,
              620.0,
            );

            final illustrationHeight = (pageHeight * 0.46).clamp(180.0, 280.0);

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(24, isShort ? 8 : 12, 24, 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Brand and Skip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.shield_rounded, color: blue, size: 34),
                          SizedBox(width: 8),
                          Text.rich(
                            TextSpan(
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
                              fontSize: 27,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Swipeable slides
                  SizedBox(
                    height: pageHeight,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _pages.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (context, index) {
                        final page = _pages[index];

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Illustration
                            SizedBox(
                              height: illustrationHeight,
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: lightBlue,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      top: 24,
                                      left: 24,
                                      child: _circle(
                                        44,
                                        const Color(0xFFD6E4FF),
                                      ),
                                    ),
                                    Positioned(
                                      top: 38,
                                      right: 25,
                                      child: _circle(34, Colors.white),
                                    ),
                                    Positioned(
                                      bottom: 30,
                                      left: 30,
                                      child: Icon(
                                        Icons.favorite_rounded,
                                        color: Colors.red.shade300,
                                        size: 34,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 30,
                                      right: 28,
                                      child: Icon(
                                        Icons.directions_car_rounded,
                                        color: Colors.lightBlue.shade300,
                                        size: 38,
                                      ),
                                    ),
                                    Container(
                                      width: illustrationHeight * 0.53,
                                      height: illustrationHeight * 0.53,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        page.icon,
                                        color: page.color,
                                        size: illustrationHeight * 0.31,
                                      ),
                                    ),
                                    Positioned(
                                      top: 55,
                                      right: 65,
                                      child: Container(
                                        padding: const EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            13,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.verified_rounded,
                                          color: page.color,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 28,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                        child: Text(
                                          page.caption,
                                          style: const TextStyle(
                                            color: navy,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: isShort ? 22 : 32),

                            // Heading
                            Text(
                              page.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isShort ? 23 : 28,
                                height: 1.22,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.7,
                                color: navy,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Description
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Text(
                                page.description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isShort ? 13 : 14,
                                  height: 1.55,
                                  color: grey,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: index == _currentPage ? 25 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: index == _currentPage
                              ? blue
                              : const Color(0xFFCBD5E1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: isShort ? 18 : 28),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage == _pages.length - 1
                                ? 'Get Started'
                                : 'Next',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Login link
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(color: grey),
                          ),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              color: blue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String caption;

  const _OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.caption,
  });
}
