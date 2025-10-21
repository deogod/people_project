import 'package:flutter/material.dart';
import 'package:people_project/home/model/user_model.dart';
import 'package:people_project/home/repository/person_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsViewModel extends ChangeNotifier {
  User? _person;
  late final PersonLocalDataSource local;

  User? get person => _person;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    local = PersonLocalDataSource(prefs: prefs);
  }

  void getPerson(String uuid) {
    final list = local.getUsers();
    _person = list.firstWhere((user) => user.login.uuid == uuid);
    notifyListeners();
  }

  Future<void> removePerson(String uuid, BuildContext context) async {
    await local.removeUser(uuid);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuário removido da base local.')),
    );
  }

  Future<void> savePerson(User person, BuildContext context) async {
    final list = local.getUsers();

    final exists = list.any((user) => user.login.uuid == person.login.uuid);

    if (!exists) {
      await local.addUser(person);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário salvo na base local!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário já existe na base local.')),
      );
    }
  }
}
