// lib/screens/notifications_screen.dart
import 'package:flutter/material.dart';

class _NotificationItem {
  final IconData icon;
  final String title;
  final String subtitle;

  const _NotificationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const _notifications = [
    _NotificationItem(
      icon: Icons.assignment_turned_in,
      title: 'Claim under review',
      subtitle: 'CLM-2002 is now being reviewed by our claims team.',
    ),
    _NotificationItem(
      icon: Icons.payment,
      title: 'Premium payment due',
      subtitle: 'Your monthly premium is due in 5 days.',
    ),
    _NotificationItem(
      icon: Icons.shield,
      title: 'Policy renewed',
      subtitle: 'Comprehensive Auto Cover was renewed successfully.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: _notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.shade100,
                child: Icon(notification.icon, color: Colors.deepPurple),
              ),
              title: Text(notification.title),
              subtitle: Text(notification.subtitle),
            ),
          );
        },
      ),
    );
  }
}
