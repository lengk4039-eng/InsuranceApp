// lib/models/claim.dart
class InsuranceClaim {
  final String id;
  final String policyId;
  final String policyTitle;
  final String claimType;
  final String description;
  final DateTime dateFiled;
  final double claimAmount;
  final String status; // Submitted, Under Review, Approved, Rejected

  InsuranceClaim({
    required this.id,
    required this.policyId,
    required this.policyTitle,
    required this.claimType,
    required this.description,
    required this.dateFiled,
    required this.claimAmount,
    this.status = 'Submitted',
  });
}

/// Shared in-memory store of the signed-in user's claims, so the Dashboard,
/// Claims list, and Claim detail screens all see the same data.
class ClaimsRepository {
  ClaimsRepository._internal();
  static final ClaimsRepository instance = ClaimsRepository._internal();

  int _sequence = 2003;

  final List<InsuranceClaim> _claims = [
    InsuranceClaim(
      id: 'CLM-2001',
      policyId: 'POL-101',
      policyTitle: 'Comprehensive Auto Cover',
      claimType: 'Accident Damage',
      description: 'Rear bumper damage from a parking lot collision.',
      dateFiled: DateTime(2026, 7, 12),
      claimAmount: 850.0,
      status: 'Approved',
    ),
    InsuranceClaim(
      id: 'CLM-2002',
      policyId: 'POL-102',
      policyTitle: 'Family Health Guard',
      claimType: 'Hospitalization',
      description: 'Emergency room visit and overnight observation.',
      dateFiled: DateTime(2026, 8, 20),
      claimAmount: 1200.0,
      status: 'Under Review',
    ),
  ];

  List<InsuranceClaim> get claims => List.unmodifiable(_claims);

  InsuranceClaim addClaim({
    required String policyId,
    required String policyTitle,
    required String claimType,
    required String description,
    required double claimAmount,
  }) {
    final claim = InsuranceClaim(
      id: 'CLM-${_sequence++}',
      policyId: policyId,
      policyTitle: policyTitle,
      claimType: claimType,
      description: description,
      dateFiled: DateTime.now(),
      claimAmount: claimAmount,
    );
    _claims.insert(0, claim);
    return claim;
  }
}
