import 'package:flutter/material.dart';
import '../models/policy.dart';
import '../utils/status_colors.dart';
import 'file_claim_screen.dart';
import 'notifications_screen.dart';
import 'policy_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final policies = PolicyRepository.instance.policies;
    final activeCount = policies
        .where((policy) => policy.status == 'Active')
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Management'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Summary Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.deepPurple.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Active Policies',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$activeCount Enrolled',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FileClaimScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_alert),
                      label: const Text('File Claim'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Your Policies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Policy List
            Expanded(
              child: ListView.builder(
                itemCount: policies.length,
                itemBuilder: (context, index) {
                  final policy = policies[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple.shade100,
                        child: Icon(
                          policy.category == 'Vehicle'
                              ? Icons.directions_car
                              : policy.category == 'Health'
                              ? Icons.health_and_safety
                              : Icons.favorite,
                          color: Colors.deepPurple,
                        ),
                      ),
                      title: Text(policy.title),
                      subtitle: Text(
                        'ID: ${policy.id} • Premium: \$${policy.premiumAmount}/mo',
                      ),
                      trailing: Chip(
                        label: Text(
                          policy.status,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: statusColor(policy.status),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PolicyDetailScreen(policy: policy),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
