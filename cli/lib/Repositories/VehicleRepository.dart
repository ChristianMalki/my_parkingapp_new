import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared/shared.dart';

class Vehiclerepository {
  Vehiclerepository? get instance => null;

  Future add(Vehicle vehicle) async {
    // send item serialized as json over http to server at localhost:8080
    final uri = Uri.parse("http://localhost:8080/vehicle");

    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(vehicle.toJson()));

    final json = jsonDecode(response.body);

    return Vehicle.fromJson(json);
  }

  Future<List<Vehicle>> getAll() async {
    final uri = Uri.parse("http://localhost:8080/vehicle");
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return (json as List).map((item) => Vehicle.fromJson(item)).toList();
  }

  Future update(Vehicle updateVehicle) async {
    // send item serialized as json over http to server at localhost:8080
    final uri =
        Uri.parse("http://localhost:8080/vehicle/${updateVehicle.id}");

    Response response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updateVehicle.toJson()));

    final json = jsonDecode(response.body);

    return Vehicle.fromJson(json);
  }

  Future delete(String id) async {
    final uri = Uri.parse("http://localhost:8080/vehicle/${id}");

    Response response = await http.delete(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future create(Vehicle vehicle) async {
    // send item serialized as json over http to server at localhost:8080
    final uri = Uri.parse("http://localhost:8080/vehicle");

    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(vehicle.toJson()));

    final json = jsonDecode(response.body);

    return Vehicle.fromJson(json);
  }
}


