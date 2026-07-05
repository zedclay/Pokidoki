import '../../features/authentication/domain/auth_models.dart';

/// Holds access tokens in memory only and coordinates refresh single-flight.
class AuthSessionManager {
  String? _accessToken;
  int? _accessTokenExpiresIn;
  AuthenticatedUser? _currentUser;
  Future<AuthSession>? _refreshInFlight;

  String? get accessToken => _accessToken;

  int? get accessTokenExpiresIn => _accessTokenExpiresIn;

  AuthenticatedUser? get currentUser => _currentUser;

  bool get hasAccessToken => _accessToken != null && _accessToken!.isNotEmpty;

  void establishSession(AuthSession session, {AuthenticatedUser? user}) {
    _accessToken = session.accessToken;
    _accessTokenExpiresIn = session.accessTokenExpiresIn;
    _currentUser = user ?? session.user;
  }

  void setCurrentUser(AuthenticatedUser user) {
    _currentUser = user;
  }

  void updateAccessToken({
    required String accessToken,
    required int accessTokenExpiresIn,
  }) {
    _accessToken = accessToken;
    _accessTokenExpiresIn = accessTokenExpiresIn;
  }

  Future<AuthSession> runSingleFlightRefresh(
    Future<AuthSession> Function() refresh,
  ) {
    if (_refreshInFlight != null) {
      return _refreshInFlight!;
    }

    final future = refresh();
    _refreshInFlight = future;
    return future.whenComplete(() {
      _refreshInFlight = null;
    });
  }

  void clearSession() {
    _accessToken = null;
    _accessTokenExpiresIn = null;
    _currentUser = null;
    _refreshInFlight = null;
  }
}
