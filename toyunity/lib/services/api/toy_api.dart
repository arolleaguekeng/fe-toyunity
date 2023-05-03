import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toyunity/models/toy_model.dart';
import 'static.dart';

class ApiToy {
  static addToy(ToyModel toyModel) async {
    try {
      print("============================================================");
      print(toyModel);
      print("============================================================");
      var body = jsonEncode(toyModel.toJson());
      print(body);
      final response = await http.post(
          Uri.parse(
            '${api_services.httpBaseUrl}/toy/add',
          ),
          body: body);
      if (response.statusCode == 201) {
        print(
            "*********************************************************************");
        print('Toy add succesfull');
      } else {
        print(response.body);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static getAllToys() async {
    print(
        "*********************************************************************");
    try {
      final response = await http.get(
        Uri.parse(
          '${api_services.httpBaseUrl}/toy/get-all',
        ),
      );
      Map data = jsonDecode(response.body);
      print(
          "===================================================================");
      if (response.statusCode == 200) {
        print('List of toys ');
      } else {
        print(response.body);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static Future<List<ToyModel>> getMostPopularToys() async {
    final response = await http.get(
      Uri.parse(
        '${api_services.httpBaseUrl}/toy/most-popular',
      ),
    );
    List data = jsonDecode(response.body);
    List temp = [];
    for (var i in data) {
      print(i);
      temp.add(i);
    }
    return ToyModel.recipesFromSnapshot(temp);
  }
}
