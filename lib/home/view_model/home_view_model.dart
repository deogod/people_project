import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:people_project/home/model/user_model.dart';
import 'package:people_project/home/repository/person_remote_data_source.dart';
import 'package:http/http.dart' as http;

class ViewModel extends ChangeNotifier {
  final List<User> _people = [];
  bool loading = false;
  final remote = PersonRemoteDataSource(client: http.Client());

  UnmodifiableListView get people => UnmodifiableListView(_people);

  void setPeople() {
    _people.clear();
    _people.addAll(_people);
    notifyListeners();
  }

  void getPerson() async {
    loading = true;
    notifyListeners();
    final user = await remote.getRandomUser();
    loading = false;
    addPerson(user);
  }

  void addPerson(User person) {
    _people.add(person);
    notifyListeners();
  }

  void removePerson(User person) {
    _people.remove(person);
    notifyListeners();
  }
}
