// lib/models/policy.dart
class InsurancePolicy {
  final String id;
  final String title;
  final String category; // e.g., Health, Vehicle, Life
  final double premiumAmount;
  final String coverageDetails;
  final String status; // Active, Expired, Pending

  InsurancePolicy({
    required this.id,
    required this.title,
    required this.category,
    required this.premiumAmount,
    required this.coverageDetails,
    this.status = 'Active',
  });
}