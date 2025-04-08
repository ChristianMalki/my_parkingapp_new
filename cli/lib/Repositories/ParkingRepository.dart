import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared/shared.dart';

class ParkingRepository {
  ParkingRepository? get instance => null;

  Future add(Parking parking) async {
    // send item serialized as json over http to server at localhost:8080
    final uri = Uri.parse("http://localhost:8080/parkings");

    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parking.toJson()));

    final json = jsonDecode(response.body);

    return Parking.fromJson(json);
  }

  Future<List<Parking>> getAll() async {
    final uri = Uri.parse("http://localhost:8080/parkings");
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return (json as List).map((item) => Parking.fromJson(item)).toList();
  }

  Future update(Parking updatedParking) async {
    // send item serialized as json over http to server at localhost:8080
    final uri =
        Uri.parse("http://localhost:8080/parkings/${updatedParking.id}");

    Response response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedParking.toJson()));

    final json = jsonDecode(response.body);

    return Parking.fromJson(json);
  }

  Future delete(String id) async {
    final uri = Uri.parse("http://localhost:8080/parkings/${id}");

    Response response = await http.delete(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future create(Parking parking) async {
    // send item serialized as json over http to server at localhost:8080
    final uri = Uri.parse("http://localhost:8080/parkings");

    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parking.toJson()));

    final json = jsonDecode(response.body);

    return Parking.fromJson(json);
  }
}


/* 

class ItemRepository implements RepositoryInterface<Item> {
  @override
  Future<Item> getById(String id) async {
    final uri = Uri.parse("http://localhost:8080/items/${id}");

    Response response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return Item.fromJson(json);
  }

  @override
  Future<Item> create(Item item) async {
    // send item serialized as json over http to server at localhost:8080
    final uri = Uri.parse("http://localhost:8080/items");

    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(item.toJson()));

    final json = jsonDecode(response.body);

    return Item.fromJson(json);
  }

  @override
  Future<List<Item>> getAll() async {
    final uri = Uri.parse("http://localhost:8080/items");
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return (json as List).map((item) => Item.fromJson(item)).toList();
  }

  @override
  Future<Item> delete(String id) async {
    final uri = Uri.parse("http://localhost:8080/items/${id}");

    Response response = await http.delete(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return Item.fromJson(json);
  }

  @override
  Future<Item> update(String id, Item item) async {
    // send item serialized as json over http to server at localhost:8080
    final uri = Uri.parse("http://localhost:8080/items/${id}");

    Response response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(item.toJson()));

    final json = jsonDecode(response.body);

    return Item.fromJson(json);
  }
}

 */


 
