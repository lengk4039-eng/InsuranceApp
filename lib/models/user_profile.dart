// lib/models/user_profile.dart

/// Shared in-memory profile for the signed-in user. A real app would load
/// this from a backend after authentication; here it just holds the values
/// entered on Register/Edit Profile so every screen sees the same data.
class UserProfile {
  UserProfile._internal();
  static final UserProfile instance = UserProfile._internal();

  String name = 'Alex Johnson';
  String email = 'alex.johnson@example.com';
  String phone = '+1 555-123-4567';

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    final first = parts.first[0];
    final last = parts.length > 1 ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }
}
