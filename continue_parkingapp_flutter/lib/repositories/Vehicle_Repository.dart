import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared/shared.dart';



class VehicleRepository{


  @override
  Future<Vehicle> getById(String id) async {
    final uri = Uri.parse("http://10.0.2.2:8080/vehicle/${id}");

    Response response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return Vehicle.fromJson(json);
  }

  @override
  Future<Vehicle> create(Vehicle vehicle) async {
    // send Vehicle serialized as json over http to server at 10.0.2.2:8080
    final uri = Uri.parse("http://10.0.2.2:8080/vehicle");

    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(vehicle.toJson()));

    final json = jsonDecode(response.body);

    return Vehicle.fromJson(json);
  }

  @override
  Future<List<Vehicle>> getAll() async {


    final uri = Uri.parse("http://10.0.2.2:8080/vehicle");
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return (json as List).map((vehicle) => Vehicle.fromJson(vehicle)).toList();
  }

  @override
  Future<Vehicle> delete(String id) async {
    final uri = Uri.parse("http://10.0.2.2:8080/vehicle/${id}");

    Response response = await http.delete(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return Vehicle.fromJson(json);
  }

  @override
  Future<Vehicle> update(String id, Vehicle vehicle) async {
    // send Vehicle serialized as json over http to server at 10.0.2.2:8080
    final uri = Uri.parse("http://10.0.2.2:8080/vehicle/${id}");

    Response response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(vehicle.toJson()));

    final json = jsonDecode(response.body);

    return Vehicle.fromJson(json);
  }
}