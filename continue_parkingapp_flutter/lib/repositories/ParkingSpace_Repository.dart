import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared/shared.dart';



class ParkingSpaceRepository {}

  @override
  Future<ParkingSpace> getById(String id) async {
    final uri = Uri.parse("http://10.0.2.2:8080/parkingspace/${id}");

    Response response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return ParkingSpace.fromJson(json);
  }

  @override
  Future<ParkingSpace> create(ParkingSpace parkingspace) async {
    // send parkingspace serialized as json over http to server at 10.0.2.2:8080
    final uri = Uri.parse("http://10.0.2.2:8080/parkingspace");

    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parkingspace.toJson()));

    final json = jsonDecode(response.body);

    return ParkingSpace.fromJson(json);
  }

  @override
  Future<List<ParkingSpace>> getAll() async {


    final uri = Uri.parse("http://10.0.2.2:8080/parkingspace");
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return (json as List).map((parkingspace) => ParkingSpace.fromJson(parkingspace)).toList();
  }

  @override
  Future<ParkingSpace> delete(String id) async {
    final uri = Uri.parse("http://10.0.2.2:8080/parkingsspace/${id}");

    Response response = await http.delete(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return ParkingSpace.fromJson(json);
  }

  @override
  Future<ParkingSpace> update(String id, ParkingSpace parkingspace) async {
    // send parking serialized as json over http to server at 10.0.2.2:8080
    final uri = Uri.parse("http://10.0.2.2:8080/parkingsspace/${id}");

    Response response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parkingspace.toJson()));

    final json = jsonDecode(response.body);

    return ParkingSpace.fromJson(json);
  }
