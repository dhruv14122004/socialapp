class AppConst {
  static const appName = 'hotline';
  static const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://fpdkmmixslspxpdhefsh.supabase.co',
  );
  static const supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZwZGttbWl4c2xzcHhwZGhlZnNoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ4MDY5NTAsImV4cCI6MjA3MDM4Mjk1MH0.xzne8RdJYaO2dIKxX97xlVZIJv1A3Zp0iz1bUjt-WIk',
  );
  static const storageBucketMedia = 'media';
}
