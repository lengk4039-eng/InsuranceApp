// lib/screens/file_claim_screen.dart
import 'package:flutter/material.dart';
import '../models/claim.dart';
import '../models/policy.dart';

class FileClaimScreen extends StatefulWidget {
  final InsurancePolicy? preselectedPolicy;

  const FileClaimScreen({super.key, this.preselectedPolicy});

  @override
  State<FileClaimScreen> createState() => _FileClaimScreenState();
}

class _FileClaimScreenState extends State<FileClaimScreen> {
  static const _claimTypes = [
    'Accident Damage',
    'Theft',
    'Hospitalization',
    'Natural Disaster',
    'Other',
  ];

  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  InsurancePolicy? _selectedPolicy;
  String _selectedClaimType = _claimTypes.first;

  @override
  void initState() {
    super.initState();
    _selectedPolicy = widget.preselectedPolicy;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedPolicy == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a policy')),
      );
      return;
    }

    final claim = ClaimsRepository.instance.addClaim(
      policyId: _selectedPolicy!.id,
      policyTitle: _selectedPolicy!.title,
      claimType: _selectedClaimType,
      description: _descriptionController.text.trim(),
      claimAmount: double.tryParse(_amountController.text.trim()) ?? 0,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Claim ${claim.id} submitted successfully')),
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final policies = PolicyRepository.instance.policies;

    return Scaffold(
      appBar: AppBar(
        title: const Text('File a Claim'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<InsurancePolicy>(
                value: _selectedPolicy,
                decoration: const InputDecoration(
                  labelText: 'Policy',
                  border: OutlineInputBorder(),
                ),
                items: policies
                    .map(
                      (policy) => DropdownMenuItem(
                        value: policy,
                        child: Text(
                          '${policy.title} (${policy.id})',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _selectedPolicy = value),
                validator: (value) =>
                    value == null ? 'Please select a policy' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedClaimType,
                decoration: const InputDecoration(
                  labelText: 'Claim Type',
                  border: OutlineInputBorder(),
                ),
                items: _claimTypes
                    .map(
                      (type) => DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedClaimType = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Claim Amount (\$)',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the claim amount';
                  }
                  if (double.tryParse(value.trim()) == null) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'What happened?',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please describe the incident';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'SUBMIT CLAIM',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
