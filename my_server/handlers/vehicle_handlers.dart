import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

VehicleRepository repo = VehicleRepository();

class VehicleRepository {
  getAll() {}
  
  create(vehicle) {}
  
  getById(String id) {}
  
  update(String id, Vehicle? vehicle) {}
  
  delete(String id) {}
}

Future<Response> postVehicleHandler(Request request) async {
  final data = await request.readAsString();
  final json = jsonDecode(data);
  var vehicle = Vehicle.fromJson(json);

  vehicle = await repo.create(vehicle);

  return Response.ok(
    jsonEncode(vehicle),
    headers: {'Content-Type': 'application/json'},
  );
}

class Vehicle {
  static fromJson(json) {}
}

Future<Response> getVehiclesHandler(Request request) async {
  final vehicles = await repo.getAll();

  final payload = vehicles.map((e) => e.toJson()).toList();

  return Response.ok(
    jsonEncode(payload),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getVehicleHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    var vehicle = await repo.getById(id);

    return Response.ok(
      jsonEncode(vehicle),
      headers: {'Content-Type': 'application/json'},
    );
  }

  return Response.badRequest();
}

Future<Response> updateVehicleHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    final data = await request.readAsString();
    final json = jsonDecode(data);
    Vehicle? vehicle = Vehicle.fromJson(json);
    vehicle = await repo.update(id, vehicle);

    return Response.ok(
      jsonEncode(vehicle),
      headers: {'Content-Type': 'application/json'},
    );
  }

  return Response.badRequest();
}

Future<Response> deleteVehicleHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    var vehicle = await repo.delete(id);

    return Response.ok(
      jsonEncode(vehicle),
      headers: {'Content-Type': 'application/json'},
    );
  }

  return Response.badRequest();
}
