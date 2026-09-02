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

/// Shared in-memory store of the signed-in user's policies.
///
/// A real app would fetch this from a backend; every screen that needs the
/// policy list reads from this single source so the data stays consistent.
class PolicyRepository {
  PolicyRepository._internal();
  static final PolicyRepository instance = PolicyRepository._internal();

  final List<InsurancePolicy> policies = [
    InsurancePolicy(
      id: 'POL-101',
      title: 'Comprehensive Auto Cover',
      category: 'Vehicle',
      premiumAmount: 120.0,
      coverageDetails:
          'Full collision, theft, and third-party coverage for your vehicle, '
          'including roadside assistance and a courtesy car during repairs.',
      status: 'Active',
    ),
    InsurancePolicy(
      id: 'POL-102',
      title: 'Family Health Guard',
      category: 'Health',
      premiumAmount: 250.0,
      coverageDetails:
          'In-patient hospital care, prescription coverage, and annual '
          'wellness check-ups for you and up to 4 dependents.',
      status: 'Active',
    ),
    InsurancePolicy(
      id: 'POL-103',
      title: 'Term Life Secure',
      category: 'Life',
      premiumAmount: 65.0,
      coverageDetails:
          '20-year term life policy with a \$250,000 death benefit and '
          'optional critical illness rider.',
      status: 'Pending',
    ),
  ];

  InsurancePolicy? byId(String id) {
    for (final policy in policies) {
      if (policy.id == id) return policy;
    }
    return null;
  }
}
