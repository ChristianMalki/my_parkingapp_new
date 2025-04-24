import 'dart:convert';


import 'package:my_server/Repositories/VehicleRepository.dart';
import 'package:shared/shared.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
 
var repo = VehicleRepository();

Future<Response> postVehicleHandler(Request request) async {
  final data = await request.readAsString();
  final json = jsonDecode(data);
  var vehicle = Vehicle.fromJson(json);

  await repo.create(vehicle);

  return Response.ok(
    jsonEncode(vehicle.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getVehiclesHandler(Request request) async {
  final vehicle = await repo.getAll();

  final payload = vehicle.map((e) => e.toJson()).toList();

  return Response.ok(
    jsonEncode(payload),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getVehicleHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    var vehicle = await repo.getAll();

    for (var vehicle in vehicle) {
      if (vehicle.id == id) {
        return Response.ok(
          jsonEncode(vehicle.toJson()),
          headers: {'Content-Type': 'application/json'},
        );
      }
    }

    return Response.notFound(
      'Vehicle with id $id not found',
      headers: {'Content-Type': 'application/json'},
    );
  }

  // better error handling could be implemented
  return Response.badRequest();
}

Future<Response> updateVehicleHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    final data = await request.readAsString();
    final json = jsonDecode(data);
    Vehicle? vehicle = Vehicle.fromJson(json);

    await repo.update(vehicle.id,vehicle);

    return Response.ok(
      jsonEncode(vehicle.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  // TODO: Implement better error handling
  return Response.badRequest();
}

Future<Response> deleteVehicleHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    try {
      await repo.delete(id);

      return Response.ok(
        jsonEncode(true),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return Response.notFound(
        'Vehicle with name $id not found',
        headers: {'Content-Type': 'application/json'},
      );
    }
  }

  // TODO: Implement better error handling
  return Response.badRequest();
}
