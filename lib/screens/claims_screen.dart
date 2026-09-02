// lib/screens/claims_screen.dart
import 'package:flutter/material.dart';
import '../models/claim.dart';
import '../utils/status_colors.dart';
import 'claim_detail_screen.dart';
import 'file_claim_screen.dart';

class ClaimsScreen extends StatefulWidget {
  const ClaimsScreen({super.key});

  @override
  State<ClaimsScreen> createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen> {
  Future<void> _openFileClaim() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FileClaimScreen()),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final claims = ClaimsRepository.instance.claims;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Claims'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: claims.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      size: 64,
                      color: Colors.deepPurple.shade200,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "You haven't filed any claims yet.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: claims.length,
              itemBuilder: (context, index) {
                final claim = claims[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade100,
                      child: const Icon(
                        Icons.description_outlined,
                        color: Colors.deepPurple,
                      ),
                    ),
                    title: Text(claim.claimType),
                    subtitle: Text(
                      '${claim.id} • ${claim.policyTitle}\n'
                      '\$${claim.claimAmount.toStringAsFixed(2)} • '
                      '${claim.dateFiled.day}/${claim.dateFiled.month}/${claim.dateFiled.year}',
                    ),
                    isThreeLine: true,
                    trailing: Chip(
                      label: Text(
                        claim.status,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: statusColor(claim.status),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ClaimDetailScreen(claim: claim),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openFileClaim,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('File Claim'),
      ),
    );
  }
}
