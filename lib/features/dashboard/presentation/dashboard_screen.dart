import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/auth_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      await AuthService().logout();

      // The router detects the signed-out state and redirects to login.
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to log out. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('InsureAI Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Log out',
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome${user?.displayName == null ? '' : ', ${user!.displayName}'}!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(user?.email ?? 'Signed in'),
            const SizedBox(height: 24),
            const Card(
              child: ListTile(
                leading: Icon(Icons.description_outlined),
                title: Text('My Insurance Policies'),
                subtitle: Text('View and manage your policies'),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.calculate_outlined),
                title: Text('EMI Calculator'),
                subtitle: Text('Calculate your monthly payments'),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.health_and_safety_outlined),
                title: Text('Health Insurance'),
                subtitle: Text('Explore health coverage options'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
