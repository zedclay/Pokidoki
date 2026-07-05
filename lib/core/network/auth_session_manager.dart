import '../../features/authentication/domain/auth_models.dart';

typedef AccessTokenListener = void Function(String? accessToken);

/// Holds access tokens in memory only and coordinates refresh single-flight.
class AuthSessionManager {
  String? _accessToken;
  int? _accessTokenExpiresIn;
  AuthenticatedUser? _currentUser;
  Future<AuthSession>? _refreshInFlight;
  final List<AccessTokenListener> _accessTokenListeners = [];

  String? get accessToken => _accessToken;

  int? get accessTokenExpiresIn => _accessTokenExpiresIn;

  AuthenticatedUser? get currentUser => _currentUser;

  bool get hasAccessToken => _accessToken != null && _accessToken!.isNotEmpty;

  void addAccessTokenListener(AccessTokenListener listener) {
    _accessTokenListeners.add(listener);
  }

  void removeAccessTokenListener(AccessTokenListener listener) {
    _accessTokenListeners.remove(listener);
  }

  void _notifyAccessTokenChanged() {
    final token = _accessToken;
    for (final listener in List<AccessTokenListener>.of(
      _accessTokenListeners,
    )) {
      listener(token);
    }
  }

  void establishSession(AuthSession session, {AuthenticatedUser? user}) {
    _accessToken = session.accessToken;
    _accessTokenExpiresIn = session.accessTokenExpiresIn;
    _currentUser = user ?? session.user;
    _notifyAccessTokenChanged();
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
    _notifyAccessTokenChanged();
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
    _notifyAccessTokenChanged();
  }
}
