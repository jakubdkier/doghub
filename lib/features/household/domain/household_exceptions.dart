enum JoinFailure { invalidCode, notFound, expired, offline, denied }

class JoinHouseholdException implements Exception {
  const JoinHouseholdException(this.reason);

  final JoinFailure reason;

  @override
  String toString() => 'JoinHouseholdException($reason)';
}

/// Creating an invite needs a server round trip (code uniqueness).
class InviteOfflineException implements Exception {
  const InviteOfflineException();
}
