import '../../../l10n/app_localizations.dart';
import '../domain/household_exceptions.dart';

extension JoinFailureText on AppLocalizations {
  String joinFailure(JoinFailure reason) => switch (reason) {
    JoinFailure.invalidCode => joinErrorInvalidCode,
    JoinFailure.notFound => joinErrorNotFound,
    JoinFailure.expired => joinErrorExpired,
    JoinFailure.offline => joinErrorOffline,
    JoinFailure.denied => joinErrorDenied,
  };
}
