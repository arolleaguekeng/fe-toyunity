import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toyunity/models/user_model.dart';
import 'static.dart';

class ApiUser {
  static var headers = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin':
        '*', // autoriser les requêtes depuis tous les domaines
    'Access-Control-Allow-Methods':
        'GET, POST, PUT, DELETE, OPTIONS', // autoriser les méthodes HTTP courantes
    'Access-Control-Allow-Headers':
        'Origin, X-Requested-With, Content-Type, Accept' // autoriser les en-têtes courants
  };
  static signup(UserModel userModel) async {
    try {
      print("============================================================");
      print(userModel);
      print("============================================================");
      var body = jsonEncode({
        "uid": userModel.uid,
        "fullName": userModel.fullName,
        "username": userModel.username,
        "email": userModel.email,
        "password": userModel.hasPassword,
        "phone": userModel.phone,
        "image": userModel.image,
        "city": userModel.city,
        "state": userModel.state,
        "country": userModel.country
      });
      final response = await http.post(
          Uri.parse(
            '${api_services.httpBaseUrl}/signup',
          ),
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin':
                '*', // autoriser les requêtes depuis tous les domaines
            'Access-Control-Allow-Methods':
                'GET, POST, PUT, DELETE, OPTIONS', // autoriser les méthodes HTTP courantes
            'Access-Control-Allow-Headers':
                'Origin, X-Requested-With, Content-Type, Accept' // autoriser les en-têtes courants
          },
          body: body);
      if (response.statusCode == 201) {
        print('succesfull signup opération');
      } else {
        print(response.body);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static Future<UserModel> login(String id) async {
    final response = await http.get(
      Uri.parse(
        '${api_services.httpBaseUrl}/login/${id}',
      ),
    );
    print(
        "============================================================================");
    if (response.statusCode == 200) {
      print('succesfull login opération');
    } else {
      print(response.body);
    }
    var data = jsonDecode(response.body);
    print(data);
    return UserModel.fromJson(data);
  }
}
