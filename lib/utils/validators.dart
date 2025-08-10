class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!value.endsWith('@jklu.edu.in')) return 'Use your @jklu.edu.in email';
    return null;
  }

  static String? required(String? value, {String field = 'This field'}) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.length < 6) return 'Min 6 characters';
    return null;
  }
}
