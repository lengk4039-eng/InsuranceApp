// lib/screens/claim_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/claim.dart';
import '../utils/status_colors.dart';

class ClaimDetailScreen extends StatelessWidget {
  final InsuranceClaim claim;

  const ClaimDetailScreen({super.key, required this.claim});

  static const _stages = ['Submitted', 'Under Review', 'Approved'];

  @override
  Widget build(BuildContext context) {
    final isRejected = claim.status == 'Rejected';
    final currentStageIndex = isRejected
        ? 1
        : _stages.indexOf(claim.status).clamp(0, _stages.length - 1);

    return Scaffold(
      appBar: AppBar(
        title: Text(claim.id),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          claim.claimType,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Chip(
                          label: Text(
                            claim.status,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: statusColor(claim.status),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    _InfoRow(label: 'Policy', value: claim.policyTitle),
                    const SizedBox(height: 12),
                    _InfoRow(label: 'Policy ID', value: claim.policyId),
                    const SizedBox(height: 12),
                    _InfoRow(
                      label: 'Claim Amount',
                      value: '\$${claim.claimAmount.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: 12),
                    _InfoRow(
                      label: 'Date Filed',
                      value:
                          '${claim.dateFiled.day}/${claim.dateFiled.month}/${claim.dateFiled.year}',
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(claim.description, style: const TextStyle(height: 1.4)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Claim Progress',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (isRejected)
              const ListTile(
                leading: Icon(Icons.cancel, color: Colors.red),
                title: Text('Claim Rejected'),
                subtitle: Text(
                  'This claim did not meet the policy coverage criteria.',
                ),
              )
            else
              ...List.generate(_stages.length, (index) {
                final reached = index <= currentStageIndex;
                return ListTile(
                  leading: Icon(
                    reached ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: reached ? Colors.green : Colors.grey,
                  ),
                  title: Text(_stages[index]),
                );
              }),
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
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
