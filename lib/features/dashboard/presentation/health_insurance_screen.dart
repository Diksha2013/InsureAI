import 'package:flutter/material.dart';

class HealthInsuranceScreen extends StatefulWidget {
  const HealthInsuranceScreen({super.key});

  @override
  State<HealthInsuranceScreen> createState() => _HealthInsuranceScreenState();
}

class _HealthInsuranceScreenState extends State<HealthInsuranceScreen> {
  static const blue = Color(0xFF1769FF);
  static const darkBlue = Color(0xFF10204A);

  final List<Map<String, String>> healthPolicies = [];

  Future<void> _addHealth() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (_) => const AddHealthScreen()),
    );

    if (result != null && mounted) {
      setState(() {
        healthPolicies.add(result);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Health policy added successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: const Text(
          'Health Insurance',
          style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        iconTheme: const IconThemeData(color: darkBlue),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [blue, Color(0xFF5795FF)]),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.health_and_safety_rounded,
                  color: Colors.white,
                  size: 42,
                ),
                SizedBox(height: 16),
                Text(
                  'Protect Your Health',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Manage your health insurance policies in one place.',
                  style: TextStyle(color: Colors.white, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'My Health Policies',
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${healthPolicies.length} policies',
                style: const TextStyle(color: Colors.blueGrey),
              ),
            ],
          ),
          const SizedBox(height: 14),

          if (healthPolicies.isEmpty)
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.medical_information_outlined,
                    size: 55,
                    color: blue,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'No Health Policies Yet',
                    style: TextStyle(
                      color: darkBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap Add Health to register your policy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ],
              ),
            )
          else
            ...healthPolicies.map(_policyCard),

          const SizedBox(height: 20),

          SizedBox(
            height: 54,
            child: FilledButton.icon(
              onPressed: _addHealth,
              icon: const Icon(Icons.add_rounded),
              label: const Text(
                'Add Health',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _policyCard(Map<String, String> policy) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5EAF3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFFEAF1FF),
                child: Icon(Icons.health_and_safety, color: blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  policy['planName'] ?? 'Health Policy',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
              ),
              const Icon(Icons.check_circle, color: Colors.green),
            ],
          ),
          const SizedBox(height: 16),
          _info('Policy Number', policy['policyNumber']),
          _info('Provider', policy['provider']),
          _info('Policy Type', policy['policyType']),
          _info('Covered Members', policy['members']),
          _info('Coverage Amount', '₹${policy['coverage']}'),
          _info('Annual Premium', '₹${policy['premium']}'),
          _info('Expiry Date', policy['expiryDate']),
        ],
      ),
    );
  }

  Widget _info(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.blueGrey, fontSize: 13),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value ?? '-',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: darkBlue,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddHealthScreen extends StatefulWidget {
  const AddHealthScreen({super.key});

  @override
  State<AddHealthScreen> createState() => _AddHealthScreenState();
}

class _AddHealthScreenState extends State<AddHealthScreen> {
  static const blue = Color(0xFF1769FF);

  final _formKey = GlobalKey<FormState>();

  final _policyNumber = TextEditingController();
  final _provider = TextEditingController();
  final _planName = TextEditingController();
  final _policyType = TextEditingController();
  final _members = TextEditingController();
  final _coverage = TextEditingController();
  final _premium = TextEditingController();
  final _expiryDate = TextEditingController();

  @override
  void dispose() {
    _policyNumber.dispose();
    _provider.dispose();
    _planName.dispose();
    _policyType.dispose();
    _members.dispose();
    _coverage.dispose();
    _premium.dispose();
    _expiryDate.dispose();
    super.dispose();
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  void _saveHealth() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(context, <String, String>{
      'policyNumber': _policyNumber.text.trim(),
      'provider': _provider.text.trim(),
      'planName': _planName.text.trim(),
      'policyType': _policyType.text.trim(),
      'members': _members.text.trim(),
      'coverage': _coverage.text.trim(),
      'premium': _premium.text.trim(),
      'expiryDate': _expiryDate.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: const Text('Add Health'),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Enter Health Policy Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF10204A),
              ),
            ),
            const SizedBox(height: 20),
            _field('Policy Number', _policyNumber),
            _field('Insurance Provider', _provider),
            _field('Plan Name', _planName),
            _field('Policy Type', _policyType),
            _field(
              'Number of Covered Members',
              _members,
              keyboardType: TextInputType.number,
            ),
            _field(
              'Coverage Amount',
              _coverage,
              keyboardType: TextInputType.number,
            ),
            _field(
              'Annual Premium',
              _premium,
              keyboardType: TextInputType.number,
            ),
            _field('Expiry Date', _expiryDate),
            const SizedBox(height: 10),
            SizedBox(
              height: 54,
              child: FilledButton(
                onPressed: _saveHealth,
                style: FilledButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Save Health',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
