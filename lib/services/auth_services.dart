class AuthService {
  static String? _fakeToken;

  static bool get isLoggedIn => _fakeToken != null;

  static Future<bool> login(String email, String password) async {
    // ⚠️ Login fittizio
    if (email == 'utente@ciclo.com' && password == '123456') {
      _fakeToken = 'mock-token';
      return true;
    }
    return false;
  }

  static void logout() {
    _fakeToken = null;
  }
}
