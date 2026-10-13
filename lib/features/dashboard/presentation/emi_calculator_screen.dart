import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmiCalculatorScreen extends StatefulWidget {
  const EmiCalculatorScreen({super.key});

  @override
  State<EmiCalculatorScreen> createState() => _EmiCalculatorScreenState();
}

class _EmiCalculatorScreenState extends State<EmiCalculatorScreen> {
  static const Color blue = Color(0xFF1769FF);
  static const Color darkBlue = Color(0xFF10204A);
  static const Color background = Color(0xFFF5F7FC);

  final _amountController = TextEditingController(text: '500000');
  final _rateController = TextEditingController(text: '9.5');
  final _tenureController = TextEditingController(text: '60');

  double _amount = 500000;
  double _rate = 9.5;
  int _months = 60;

  double get monthlyEmi {
    if (_amount <= 0 || _months <= 0) return 0;

    final monthlyRate = _rate / 1200;

    if (monthlyRate == 0) return _amount / _months;

    final factor = _pow(1 + monthlyRate, _months);

    return _amount * monthlyRate * factor / (factor - 1);
  }

  double _pow(double base, int exponent) {
    double result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }

  double get totalPayment => monthlyEmi * _months;

  double get totalInterest => totalPayment - _amount;

  String _money(double value) {
    final rounded = value.round().toString();
    final result = StringBuffer();

    for (int i = 0; i < rounded.length; i++) {
      if (i > 0 &&
          (rounded.length - i) > 3 &&
          (rounded.length - i - 3) % 2 == 0) {
        result.write(',');
      }
      result.write(rounded[i]);
    }

    return '₹$result';
  }

  void _updateAmount(String value) {
    final parsed = double.tryParse(value);
    if (parsed == null || parsed <= 0) return;

    setState(() {
      _amount = parsed.clamp(1000, 100000000).toDouble();
    });
  }

  void _updateRate(String value) {
    final parsed = double.tryParse(value);
    if (parsed == null || parsed < 0 || parsed > 50) return;

    setState(() => _rate = parsed);
  }

  void _updateTenure(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null || parsed <= 0) return;

    setState(() => _months = parsed.clamp(1, 360));
  }

  @override
  void dispose() {
    _amountController.dispose();
    _rateController.dispose();
    _tenureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkBlue),
        title: const Text(
          'EMI Management',
          style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Expanded(child: _tab('EMI Calculator', true)),
                Expanded(child: _tab('My EMIs', false, onTap: _showMyEmis)),
              ],
            ),
            const SizedBox(height: 26),

            _inputSection(
              title: 'Loan Amount (₹)',
              controller: _amountController,
              keyboardType: TextInputType.number,
              onChanged: _updateAmount,
              slider: Slider(
                value: _amount.clamp(1000, 100000000).toDouble(),
                min: 1000,
                max: 10000000,
                divisions: 9999,
                activeColor: blue,
                onChanged: (value) {
                  setState(() {
                    _amount = value;
                    _amountController.text = value.round().toString();
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            _inputSection(
              title: 'Interest Rate (% per year)',
              controller: _rateController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: _updateRate,
              slider: Slider(
                value: _rate.clamp(0, 30).toDouble(),
                min: 0,
                max: 30,
                divisions: 300,
                activeColor: blue,
                onChanged: (value) {
                  setState(() {
                    _rate = value;
                    _rateController.text = value.toStringAsFixed(2);
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            _inputSection(
              title: 'Loan Tenure (Months)',
              controller: _tenureController,
              keyboardType: TextInputType.number,
              onChanged: _updateTenure,
              slider: Slider(
                value: _months.toDouble(),
                min: 1,
                max: 360,
                divisions: 359,
                activeColor: blue,
                onChanged: (value) {
                  setState(() {
                    _months = value.round();
                    _tenureController.text = '$_months';
                  });
                },
              ),
            ),

            const SizedBox(height: 26),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFDDE9FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    'Monthly EMI',
                    style: TextStyle(
                      color: darkBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FittedBox(
                    child: Text(
                      _money(monthlyEmi),
                      style: const TextStyle(
                        color: blue,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _resultCard(
                    'Total Payment',
                    _money(totalPayment),
                    Icons.account_balance_wallet_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _resultCard(
                    'Total Interest',
                    _money(totalInterest),
                    Icons.percent_rounded,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _showEmiSummary,
                icon: const Icon(Icons.calculate_outlined),
                label: const Text(
                  'View EMI Summary',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab(String title, bool selected, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: selected ? blue : const Color(0xFFEAF0FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? Colors.white : darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _inputSection({
    required String title,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required ValueChanged<String> onChanged,
    required Widget slider,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: darkBlue,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFDDE4F0)),
          ),
          child: Column(
            children: [
              TextField(
                controller: controller,
                keyboardType: keyboardType,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                onChanged: onChanged,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
              slider,
            ],
          ),
        ),
      ],
    );
  }

  Widget _resultCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFE5EAF3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: blue, size: 23),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
          ),
          const SizedBox(height: 7),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: const TextStyle(
                color: darkBlue,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEmiSummary() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'EMI Summary',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),
            const SizedBox(height: 18),
            _summaryRow('Loan Amount', _money(_amount)),
            _summaryRow('Interest Rate', '${_rate.toStringAsFixed(2)}% p.a.'),
            _summaryRow('Loan Tenure', '$_months months'),
            _summaryRow('Monthly EMI', _money(monthlyEmi)),
            _summaryRow('Total Interest', _money(totalInterest)),
            _summaryRow('Total Payment', _money(totalPayment)),
            const SizedBox(height: 12),
            const Text(
              'This is an estimate. Actual EMI may vary by lender.',
              style: TextStyle(color: Colors.blueGrey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showMyEmis() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.receipt_long_outlined, size: 48, color: blue),
            SizedBox(height: 12),
            Text(
              'My EMIs',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'No saved EMIs yet. EMI saving can be connected '
              'to your database when you are ready.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
