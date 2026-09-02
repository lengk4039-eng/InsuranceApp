// lib/screens/policy_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/policy.dart';
import '../utils/status_colors.dart';
import 'file_claim_screen.dart';

class PolicyDetailScreen extends StatelessWidget {
  final InsurancePolicy policy;

  const PolicyDetailScreen({super.key, required this.policy});

  IconData get _categoryIcon {
    switch (policy.category) {
      case 'Vehicle':
        return Icons.directions_car;
      case 'Health':
        return Icons.health_and_safety;
      case 'Life':
        return Icons.favorite;
      default:
        return Icons.shield;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Policy Details'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.deepPurple.shade100,
                          child: Icon(
                            _categoryIcon,
                            color: Colors.deepPurple,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                policy.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'ID: ${policy.id}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Chip(
                          label: Text(
                            policy.status,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: statusColor(policy.status),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    _InfoRow(label: 'Category', value: policy.category),
                    const SizedBox(height: 12),
                    _InfoRow(
                      label: 'Monthly Premium',
                      value: '\$${policy.premiumAmount.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Coverage Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      policy.coverageDetails,
                      style: const TextStyle(height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FileClaimScreen(preselectedPolicy: policy),
                  ),
                );
              },
              icon: const Icon(Icons.add_alert),
              label: const Text('File a Claim on This Policy'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
