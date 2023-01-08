import 'package:api_to_sqlite/src/models/employee_model.dart';
import 'package:api_to_sqlite/src/providers/db_provider.dart';
import 'package:dio/dio.dart';

class EmployeeApiProvider {
  Future<List<Game?>> getAllEmployees() async {
    var url = "http://demo6866588.mockable.io/pendinggames";
    Response response = await Dio().get(url);

    return (response.data as List).map((game) {
      // (x => fromJson(x))
      print('Inserting $game');
      DBProvider.db.createEmployee(Game.fromJson(game));
    }).toList();
  }
}
