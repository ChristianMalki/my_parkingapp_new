import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'vehicle_handlers.dart';


Future<Response> postParkingHandler(Request request) async {
  final data = await request.readAsString();
  final json = jsonDecode(data);
  var parking = Parking.fromJson(json);

  var parkingEntity = await repo.create(parking.toEntity());

  parking = await parkingEntity.toModel();

  return Response.ok(
    jsonEncode(parking.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

class Parking {
  static fromJson(json) {}
  
  toEntity() {}
  
  Object? toJson() {}
}

Future<Response> getParkingsHandler(Request request) async {
  final entities = await repo.getAll();

  final parkings = await Future.wait(entities.map((e) => e.toModel()));

  final payload = parkings.map((e) => e.toJson()).toList();

  return Response.ok(
    jsonEncode(payload),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getParkingHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    var entity = await repo.getById(id);

    var parking = await entity?.toModel();

    return Response.ok(
      jsonEncode(parking?.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  // better error handling could be implemented
  return Response.badRequest();
}

Future<Response> updateParkingHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    final data = await request.readAsString();
    final json = jsonDecode(data);
    Parking? parking = Parking.fromJson(json);
    var entity = parking?.toEntity();
    entity = await repo.update(id, entity);
    parking = await entity.toModel();

    return Response.ok(
      jsonEncode(parking?.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  // TODO: Implement better error handling
  return Response.badRequest();
}

Future<Response> deleteParkingHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    var entity = await repo.delete(id);

    var parking = await entity.toModel();

    return Response.ok(
      jsonEncode(parking.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  // TODO: Implement better error handling
  return Response.badRequest();
}
