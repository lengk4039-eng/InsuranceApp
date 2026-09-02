// lib/utils/status_colors.dart
import 'package:flutter/material.dart';

/// Maps a policy/claim status string to a consistent color used across
/// the Dashboard, Policy detail, Claims, and Claim detail screens.
Color statusColor(String status) {
  switch (status) {
    case 'Active':
    case 'Approved':
    case 'Paid':
      return Colors.green;
    case 'Pending':
    case 'Under Review':
    case 'Submitted':
      return Colors.orange;
    case 'Expired':
    case 'Rejected':
      return Colors.red;
    default:
      return Colors.blueGrey;
  }
}
