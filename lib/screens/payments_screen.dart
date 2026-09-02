// lib/screens/payments_screen.dart
import 'package:flutter/material.dart';
import '../models/policy.dart';

class _PaymentRecord {
  final String policyTitle;
  final double amount;
  final DateTime date;

  const _PaymentRecord({
    required this.policyTitle,
    required this.amount,
    required this.date,
  });
}

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final List<_PaymentRecord> _history = [
    _PaymentRecord(
      policyTitle: 'Comprehensive Auto Cover',
      amount: 120.0,
      date: DateTime(2026, 8, 1),
    ),
    _PaymentRecord(
      policyTitle: 'Family Health Guard',
      amount: 250.0,
      date: DateTime(2026, 8, 1),
    ),
    _PaymentRecord(
      policyTitle: 'Comprehensive Auto Cover',
      amount: 120.0,
      date: DateTime(2026, 7, 1),
    ),
  ];

  bool _paidThisMonth = false;

  double get _amountDue {
    final total = PolicyRepository.instance.policies
        .where((policy) => policy.status == 'Active')
        .fold<double>(0, (sum, policy) => sum + policy.premiumAmount);
    return total;
  }

  void _payNow() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Payment'),
        content: Text(
          'Pay \$${_amountDue.toStringAsFixed(2)} for this month\'s premiums?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _paidThisMonth = true;
                _history.insert(
                  0,
                  _PaymentRecord(
                    policyTitle: 'All Active Policies',
                    amount: _amountDue,
                    date: DateTime.now(),
                  ),
                );
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment successful')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Pay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 4,
            color: Colors.deepPurple.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'This Month\'s Premium',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${_amountDue.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _paidThisMonth ? null : _payNow,
                      icon: Icon(
                        _paidThisMonth ? Icons.check_circle : Icons.payment,
                      ),
                      label: Text(_paidThisMonth ? 'Paid' : 'Pay Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Payment History',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ..._history.map(
            (payment) => Card(
              margin: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.check, color: Colors.white),
                ),
                title: Text(payment.policyTitle),
                subtitle: Text(
                  '${payment.date.day}/${payment.date.month}/${payment.date.year}',
                ),
                trailing: Text(
                  '\$${payment.amount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
