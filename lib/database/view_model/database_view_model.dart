import 'package:flutter/material.dart';
import 'package:people_project/home/model/user_model.dart';
import 'package:people_project/home/repository/person_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBaseViewModel extends ChangeNotifier {
  List<User>? _people;
  late final PersonLocalDataSource local;

  List<User>? get people => _people;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    local = PersonLocalDataSource(prefs: prefs);
  }

  void getPeople() {
    _people = local.getUsers();
    notifyListeners();
  }

  void removePerson(String uuid, BuildContext context) async {
    await local.removeUser(uuid);
    _people?.removeWhere((user) => user.login.uuid == uuid);
    notifyListeners();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuário removido da base local.')),
    );
  }
}
