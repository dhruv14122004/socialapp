import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _client = Supabase.instance.client;
  static const allowedDomain = '@jklu.edu.in';

  bool _isAllowedEmail(String email) =>
      email.toLowerCase().endsWith(allowedDomain);

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    if (!_isAllowedEmail(email)) {
      throw AuthException(
        'Please use your official college email ($allowedDomain)',
      );
    }

    // Sign up with email confirmation required
    final res = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'name': name, 'joined_at': DateTime.now().toIso8601String()},
      emailRedirectTo: null, // This ensures email confirmation is required
    );

    // Don't create profile until email is verified
    // The user will need to confirm their email before they can sign in
    return res;
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    if (!_isAllowedEmail(email)) {
      throw AuthException(
        'Please use your official college email ($allowedDomain)',
      );
    }
    final res = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = res.user;
    if (user != null) {
      // Only create/update profile after successful sign in (email confirmed)
      await ensureProfile(
        userId: user.id,
        email: email,
        name: user.userMetadata?['name'] ?? email.split('@').first,
        isOnline: true,
      );
    }
    return res;
  }

  Future<void> signOut() async {
    final id = _client.auth.currentUser?.id;
    if (id != null) {
      await _client.from('users').update({'is_online': false}).eq('id', id);
    }
    await _client.auth.signOut();
  }

  Future<void> ensureProfile({
    required String userId,
    required String email,
    required String name,
    bool? isOnline,
  }) async {
    await _client.from('users').upsert({
      'id': userId,
      'email': email,
      'name': name,
      if (isOnline != null) 'is_online': isOnline,
      'joined_at': DateTime.now().toIso8601String(),
    });
  }

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;
}
