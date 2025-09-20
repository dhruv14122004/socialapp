import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final _client = Supabase.instance.client;

  Future<String> uploadMedia(File file, {required String bucket}) async {
    final userId = _client.auth.currentUser!.id;
    final fileExt = file.path.split('.').last.toLowerCase();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
    final filePath = '$userId/$fileName';

    try {
      await _client.storage.from(bucket).upload(filePath, file);
      return _client.storage.from(bucket).getPublicUrl(filePath);
    } catch (e) {
      // If upload fails, try to get public URL anyway (file might already exist)
      try {
        return _client.storage.from(bucket).getPublicUrl(filePath);
      } catch (_) {
        rethrow;
      }
    }
  }
}
