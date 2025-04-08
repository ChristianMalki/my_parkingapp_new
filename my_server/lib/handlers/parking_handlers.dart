import 'dart:convert';
import 'package:my_server/Repositories/ParkingRepository.dart';
import 'package:shared/shared.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

var repo = ParkingRepository();

Future<Response> postParkingHandler(Request request) async {
  final data = await request.readAsString();
  final json = jsonDecode(data);
  var parking = Parking.fromJson(json);

  await repo.create(parking);

  return Response.ok(
    jsonEncode(parking.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getParkingsHandler(Request request) async {
  final parkings = await repo.getAll();

  final payload = parkings.map((e) => e.toJson()).toList();

  return Response.ok(
    jsonEncode(payload),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getParkingHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    var parkings = await repo.getAll();

    for (var parking in parkings) {
      if (parking.id == id) {
        return Response.ok(
          jsonEncode(parking.toJson()),
          headers: {'Content-Type': 'application/json'},
        );
      }
    }

    return Response.notFound(
      'Parking with id $id not found',
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

    await repo.update(parking);

    return Response.ok(
      jsonEncode(parking.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  // TODO: Implement better error handling
  return Response.badRequest();
}

Future<Response> deleteParkingHandler(Request request) async {
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
        'Parking with id $id not found',
        headers: {'Content-Type': 'application/json'},
      );
    }
  }

  // TODO: Implement better error handling
  return Response.badRequest();
}
