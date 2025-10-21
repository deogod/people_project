import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:people_project/home/model/user_model.dart';

class PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSource({required this.client});

  Future<User> getRandomUser() async {
    final uri = Uri.parse('https://randomuser.me/api/');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final randomUserResponse = RandomUserResponse.fromJson(data);
      return randomUserResponse.results.first;
    } else {
      throw Exception('Erro ao carregar usuário: ${response.statusCode}');
    }
  }

  Future<List<User>> getUsers({int results = 10}) async {
    final uri = Uri.parse('https://randomuser.me/api/?results=$results');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final randomUserResponse = RandomUserResponse.fromJson(data);
      return randomUserResponse.results;
    } else {
      throw Exception(
          'Erro ao carregar lista de usuários: ${response.statusCode}');
    }
  }
}
