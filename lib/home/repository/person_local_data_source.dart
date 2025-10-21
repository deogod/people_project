import 'dart:convert';
import 'package:people_project/home/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonLocalDataSource {
  static const _cacheKey = 'cached_users';

  final SharedPreferences prefs;

  PersonLocalDataSource({required this.prefs});

  List<User> getUsers() {
    final jsonString = prefs.getString(_cacheKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      print('Erro ao decodificar usuários locais: $e');
      return [];
    }
  }

  Future<void> saveUsers(List<User> users) async {
    final encoded = jsonEncode(users.map((e) => e.toJson()).toList());
    await prefs.setString(_cacheKey, encoded);
  }

  Future<void> addUser(User user) async {
    final users = getUsers();
    users.add(user);
    await saveUsers(users);
  }

  Future<void> removeUser(String uuid) async {
    final users = getUsers();
    users.removeWhere((u) => u.login.uuid == uuid);
    await saveUsers(users);
  }

  Future<void> clear() async {
    await prefs.remove(_cacheKey);
  }
}
