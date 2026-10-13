import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insure_ai/features/dashboard/presentation/emi_calculator_screen.dart';
import 'package:insure_ai/features/dashboard/presentation/health_insurance_screen.dart';
import 'package:insure_ai/features/dashboard/presentation/vehicle_insurance_screen.dart';

const Color primaryBlue = Color(0xFF246BFD);
const Color darkBlue = Color(0xFF14264D);
const Color pageBackground = Color(0xFFF5F7FC);
const Color mutedText = Color(0xFF7C879D);
const Color borderColor = Color(0xFFE8ECF4);

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  String _search = '';

  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _services = [
    {
      'title': 'Vehicle',
      'subtitle': 'Car & bike cover',
      'icon': Icons.directions_car_rounded,
      'color': const Color(0xFF246BFD),
    },
    {
      'title': 'Health',
      'subtitle': 'Family protection',
      'icon': Icons.favorite_rounded,
      'color': const Color(0xFFF05A78),
    },
    {
      'title': 'EMI',
      'subtitle': 'Monthly payments',
      'icon': Icons.calculate_rounded,
      'color': const Color(0xFF159D78),
    },
  ];

  final List<Map<String, String>> _policies = [
    {
      'name': 'Car Insurance',
      'provider': 'Tata Nexon  •••• 1234',
      'expiry': '12 Mar 2027',
      'premium': '₹8,500',
      'icon': 'car',
    },
    {
      'name': 'Health Insurance',
      'provider': 'Family Health Cover',
      'expiry': '01 Jan 2027',
      'premium': '₹12,450',
      'icon': 'health',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigate(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/policies');
        break;
      case 2:
        context.go('/emi');
        break;
      case 3:
        context.go('/notifications');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  const SizedBox(height: 30),
                  _greeting(),
                  const SizedBox(height: 22),
                  _searchBar(),
                  const SizedBox(height: 24),
                  _recommendationCard(),
                  const SizedBox(height: 30),
                  _sectionHeader('Quick services'),
                  const SizedBox(height: 14),
                  _serviceGrid(),
                  const SizedBox(height: 30),
                  _sectionHeader(
                    'Your coverage',
                    action: 'View all',
                    onTap: () => _navigate(1),
                  ),
                  const SizedBox(height: 14),
                  ..._policies
                      .where(
                        (policy) =>
                            policy['name']!.toLowerCase().contains(
                              _search.toLowerCase(),
                            ) ||
                            policy['provider']!.toLowerCase().contains(
                              _search.toLowerCase(),
                            ),
                      )
                      .map(_policyCard),
                  const SizedBox(height: 16),
                  _emiCard(),
                  const SizedBox(height: 30),
                  _sectionHeader('Recent activity'),
                  const SizedBox(height: 14),
                  _activityCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 72,
        backgroundColor: Colors.white,
        elevation: 0,
        indicatorColor: const Color(0xFFEAF0FF),
        selectedIndex: _selectedIndex,
        onDestinationSelected: _navigate,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.shield_outlined),
            selectedIcon: Icon(Icons.shield_rounded),
            label: 'Policies',
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate_rounded),
            label: 'EMI',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none_rounded),
            selectedIcon: Icon(Icons.notifications_rounded),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            color: primaryBlue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.shield_rounded,
            color: Colors.white,
            size: 27,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'InsureAI',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: darkBlue,
                  letterSpacing: -0.7,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'YOUR SMART INSURANCE PARTNER',
                style: TextStyle(
                  fontSize: 9,
                  color: mutedText,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        _roundIconButton(Icons.notifications_none_rounded, () => _navigate(3)),
        const SizedBox(width: 10),
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => _navigate(4),
          child: const CircleAvatar(
            radius: 21,
            backgroundColor: Color(0xFFE4ECFF),
            child: Icon(Icons.person_rounded, color: primaryBlue),
          ),
        ),
      ],
    );
  }

  Widget _roundIconButton(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: darkBlue, size: 22),
        constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
      ),
    );
  }

  Widget _greeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hello 👋',
          style: TextStyle(
            color: mutedText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _searchBar() {
    return TextField(
      controller: _searchController,
      onChanged: (value) => setState(() => _search = value),
      decoration: InputDecoration(
        hintText: 'Search policies and services',
        hintStyle: const TextStyle(fontSize: 13, color: mutedText),
        prefixIcon: const Icon(Icons.search_rounded, color: primaryBlue),
        suffixIcon: _search.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _searchController.clear();
                  setState(() => _search = '');
                },
                icon: const Icon(Icons.close_rounded),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 17),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryBlue, width: 1.4),
        ),
      ),
    );
  }

  Widget _recommendationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF142D70), Color(0xFF246BFD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.13),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color: Color(0xFFFFD978),
                  size: 15,
                ),
                SizedBox(width: 7),
                Text(
                  'PERSONALIZED FOR YOU',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'AI Recommendation',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              height: 1.2,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Get personalized insurance plan based on your needs',
            style: TextStyle(
              color: Color(0xFFDCE7FF),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 48,
            child: FilledButton(
              onPressed: () => context.push('/ai-chat'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome_rounded, size: 18),
                  SizedBox(width: 9),
                  Text(
                    'Explore recommendations',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 17),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, {String? action, VoidCallback? onTap}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: darkBlue,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onTap,
            child: const Text(
              'View all',
              style: TextStyle(
                color: primaryBlue,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }

  Widget _serviceGrid() {
    final query = _search.toLowerCase().trim();

    final filtered = _services.where((service) {
      return (service['title'] as String).toLowerCase().contains(query) ||
          (service['subtitle'] as String).toLowerCase().contains(query);
    }).toList();

    if (filtered.isEmpty) {
      return _emptyState('No matching services found.');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 550 ? 3 : 3;

        return GridView.builder(
          itemCount: filtered.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 11,
            mainAxisSpacing: 11,
            mainAxisExtent: 135,
          ),
          itemBuilder: (context, index) {
            final service = filtered[index];
            final color = service['color'] as Color;

            return Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),

                onTap: () {
                  final title = service['title'] as String;

                  if (title == 'EMI') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmiCalculatorScreen(),
                      ),
                    );
                  } else if (title == 'Vehicle') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VehicleInsuranceScreen(),
                      ),
                    );
                  } else if (title == 'Health') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HealthInsuranceScreen(),
                      ),
                    );
                  } else {
                    _message('This feature is coming soon.');
                  }
                },

                child: Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          service['icon'] as IconData,
                          color: color,
                          size: 22,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        service['title'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: darkBlue,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service['subtitle'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: mutedText,
                          fontSize: 10,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _policyCard(Map<String, String> policy) {
    final isCar = policy['icon'] == 'car';
    final color = isCar ? primaryBlue : const Color(0xFFEC607C);
    final icon = isCar ? Icons.directions_car_rounded : Icons.favorite_rounded;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      policy['name']!,
                      style: const TextStyle(
                        color: darkBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      policy['provider']!,
                      style: const TextStyle(color: mutedText, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F8EF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: Color(0xFF16885A),
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 17),
            child: Divider(height: 1, color: borderColor),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _policyDetail('RENEWS ON', policy['expiry']!)),
              const SizedBox(width: 10),
              Expanded(
                child: _policyDetail('ANNUAL PREMIUM', policy['premium']!),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => _showPolicyDetails(policy),
              child: const Text(
                'View details  →',
                style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _policyDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: mutedText,
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          value,
          style: const TextStyle(
            color: darkBlue,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  void _showPolicyDetails(Map<String, String> policy) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.verified_user_rounded,
          color: primaryBlue,
          size: 38,
        ),
        title: Text(policy['name']!),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Policy: ${policy['provider']}'),
            const SizedBox(height: 12),
            Text('Renewal: ${policy['expiry']}'),
            const SizedBox(height: 12),
            Text('Premium: ${policy['premium']} per year'),
            const SizedBox(height: 14),
            const Text(
              'Sample policy information. Replace this with verified policy data from your database.',
              style: TextStyle(color: mutedText, fontSize: 12, height: 1.5),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _emiCard() {
    return Material(
      color: const Color(0xFFEAF0FF),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _navigate(2),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.calculate_rounded,
                  color: primaryBlue,
                  size: 25,
                ),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Monthly EMI',
                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'View your payment breakdown',
                      style: TextStyle(color: mutedText, fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹10,519',
                    style: TextStyle(
                      color: darkBlue,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'PER MONTH',
                    style: TextStyle(
                      color: mutedText,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _activityCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          _activityTile(
            icon: Icons.check_circle_rounded,
            color: const Color(0xFF159D78),
            title: 'Premium payment received',
            subtitle: 'Health Insurance · 12 Mar 2026',
            amount: '₹12,450',
          ),
          const Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: borderColor,
          ),
          _activityTile(
            icon: Icons.local_hospital_rounded,
            color: primaryBlue,
            title: 'Hospital claim update',
            subtitle: 'Processed · 08 Mar 2026',
            amount: '₹6,800',
          ),
        ],
      ),
    );
  }

  Widget _activityTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String amount,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      leading: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: color.withOpacity(0.10),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(icon, color: color, size: 21),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: darkBlue,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          subtitle,
          style: const TextStyle(color: mutedText, fontSize: 10),
        ),
      ),
      trailing: Text(
        amount,
        style: const TextStyle(
          color: darkBlue,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _emptyState(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          const Icon(Icons.search_off_rounded, color: mutedText, size: 32),
          const SizedBox(height: 8),
          Text(message, style: const TextStyle(color: mutedText)),
        ],
      ),
    );
  }
}
