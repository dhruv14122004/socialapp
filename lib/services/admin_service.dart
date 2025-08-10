import 'package:supabase_flutter/supabase_flutter.dart';

class AdminService {
  final _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getReports() async {
    return await _client.from('reports').select();
  }

  Future<void> banUser(String userId) async {
    await _client.from('users').update({'banned': true}).eq('id', userId);
  }

  Future<void> unbanUser(String userId) async {
    await _client.from('users').update({'banned': false}).eq('id', userId);
  }
}
