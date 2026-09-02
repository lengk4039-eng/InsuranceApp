// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailAlerts = true;
  bool _biometricLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeModeNotifier,
        builder: (context, mode, _) {
          return ListView(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Preferences',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              SwitchListTile(
                secondary: const Icon(Icons.dark_mode_outlined),
                title: const Text('Dark Mode'),
                value: mode == ThemeMode.dark,
                onChanged: (value) {
                  themeModeNotifier.value =
                      value ? ThemeMode.dark : ThemeMode.light;
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.notifications_active_outlined),
                title: const Text('Push Notifications'),
                value: _pushNotifications,
                onChanged: (value) {
                  setState(() => _pushNotifications = value);
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.mail_outline),
                title: const Text('Email Alerts'),
                value: _emailAlerts,
                onChanged: (value) {
                  setState(() => _emailAlerts = value);
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.fingerprint),
                title: const Text('Biometric Login'),
                value: _biometricLogin,
                onChanged: (value) {
                  setState(() => _biometricLogin = value);
                },
              ),
              const Divider(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.info_outline),
                  title: Text('App Version'),
                  trailing: Text('1.0.0'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
