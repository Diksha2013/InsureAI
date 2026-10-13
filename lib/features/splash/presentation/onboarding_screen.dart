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

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      title: 'One App for\nYour Complete Protection',
      description:
          'Manage all your insurance, EMIs and get personalized recommendations with the power of AI.',
      image: 'assets/images/onboarding_protection.png',
    ),
    _OnboardingData(
      title: 'Manage All Your\nPolicies in One Place',
      description:
          'Keep your health and vehicle insurance details organized and easy to access.',
      image: 'assets/images/onboarding_protection.png',
    ),
    _OnboardingData(
      title: 'Make Smarter\nFinancial Decisions',
      description:
          'Calculate EMIs and explore insurance recommendations that suit your needs.',
      image: 'assets/images/onboarding_protection.png',
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

  void _skip() {
    context.go('/login');
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
            final height = constraints.maxHeight;
            final short = height < 700;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Top bar
                  SizedBox(
                    height: 54,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _skip,
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Swipeable onboarding content
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _pages.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (context, index) {
                        final page = _pages[index];

                        return Column(
                          children: [
                            SizedBox(height: short ? 14 : 34),

                            Text(
                              page.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: short ? 25 : 29,
                                height: 1.28,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.7,
                                color: navy,
                              ),
                            ),

                            SizedBox(height: short ? 14 : 22),

                            Text(
                              page.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: grey,
                                fontSize: short ? 14 : 16,
                                height: 1.55,
                              ),
                            ),

                            SizedBox(height: short ? 14 : 28),

                            // Insurance illustration
                            Expanded(
                              child: Center(
                                child: Image.asset(
                                  page.image,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEAF1FF),
                                        borderRadius: BorderRadius.circular(28),
                                      ),
                                      child: const Icon(
                                        Icons.health_and_safety_rounded,
                                        color: blue,
                                        size: 120,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            SizedBox(height: short ? 10 : 20),
                          ],
                        );
                      },
                    ),
                  ),

                  // Page indicators
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: _currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? blue
                                : const Color(0xFFD7DDE8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Next / Get Started button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
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
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: short ? 12 : 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OnboardingData {
  final String title;
  final String description;
  final String image;

  const _OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}
