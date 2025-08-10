import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final _client = Supabase.instance.client;

  Future<String> uploadMedia(File file, {required String bucket}) async {
    final path =
        '${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
    await _client.storage.from(bucket).upload(path, file);
    return _client.storage.from(bucket).getPublicUrl(path);
  }
}
