import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared/shared.dart';

class Parkingspacerepository {
  List<ParkingSpace> _ParkingSpace = [];
  
  Future create(ParkingSpace parkingspace) async {
    // send item serialized as json over http to server at localhost:8080
    final uri = Uri.parse("http://localhost:8080/parkingspace");

    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parkingspace.toJson()));

    final json = jsonDecode(response.body);

    return ParkingSpace.fromJson(json);
  }

  Future<List<ParkingSpace>> getAll() async {
    final uri = Uri.parse("http://localhost:8080/parkingspace");
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return (json as List).map((item) => ParkingSpace.fromJson(item)).toList();
  }

  Future update(ParkingSpace updatedParkingSpace, ParkingSpace newParkingspace) async {
    // send item serialized as json over http to server at localhost:8080
    final uri =
        Uri.parse("http://localhost:8080/parkingspace/${updatedParkingSpace.id}");

    Response response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newParkingspace.toJson()));

    final json = jsonDecode(response.body);

    return ParkingSpace.fromJson(json);
  }

  Future delete(String id) async {
    final uri = Uri.parse("http://localhost:8080/parkingspace/${id}");

    Response response = await http.delete(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
  }

  
  
}


