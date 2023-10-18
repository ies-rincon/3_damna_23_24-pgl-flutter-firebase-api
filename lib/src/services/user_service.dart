// user_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_api/src/models/user_model.dart';

class UserService {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse(
          'https://damna-pgl-firebase-default-rtdb.firebaseio.com/users.json'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(response.body) as List<dynamic>;

      final List<User> users = jsonData.map((userData) {
        return User(
          id: userData['_id'],
          name: userData['name'],
          email: userData['email'],
          img: userData['img'],
        );
      }).toList();

      // Imprime la lista de usuarios en la consola para depuración
      for (var user in users) {
        print('ID: ${user.id}, Nombre: ${user.name}, Email: ${user.email}');
      }

      return users;
    } else {
      throw Exception('No se pudieron cargar los usuarios');
    }
  }
}
