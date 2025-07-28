import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared/shared.dart';



class ParkingRepository {

  @override
  Future<Parking> getById(String id) async {
    final uri = Uri.parse("http://10.0.2.2:8080/parkings/${id}");

    Response response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return Parking.fromJson(json);
  }

  @override
  Future<Parking> create(Parking parking) async {
    // send parking serialized as json over http to server at 10.0.2.2:8080
    final uri = Uri.parse("http://10.0.2.2:8080/parkings");

    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parking.toJson()));

    final json = jsonDecode(response.body);

    return Parking.fromJson(json);
  }

  @override
  Future<List<Parking>> getAll() async {


    final uri = Uri.parse("http://10.0.2.2:8080/parkings");
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return (json as List).map((parking) => Parking.fromJson(parking)).toList();
  }

  
    
  

  @override
  Future delete(String id) async {
    final uri = Uri.parse("http://10.0.2.2:8080/parkings/${id}");

    Response response = await http.delete(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

  }

  @override
  Future<Parking> update(String id, Parking parking) async {
    // send parking serialized as json over http to server at 10.0.2.2:8080
    final uri = Uri.parse("http://10.0.2.2:8080/parkings/${id}");

    Response response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parking.toJson()));

    final json = jsonDecode(response.body);

    return Parking.fromJson(json);
  }
}