import 'dart:convert';
import 'package:my_server/Repositories/ParkingSpaceRepository.dart';
import 'package:shared/shared.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

var repo = ParkingSpaceRepository();



Future<Response> postParkingSpaceHandler(Request request) async {
  final data = await request.readAsString();
  final json = jsonDecode(data);
  var parkingspace = ParkingSpace.fromJson(json);

  await repo.create(parkingspace);

  return Response.ok(
    jsonEncode(parkingspace.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getParkingSpacesHandler(Request request) async {
  final parkingspace = await repo.getAll();

  final payload = parkingspace.map((e) => e.toJson()).toList();

  return Response.ok(
    jsonEncode(payload),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getParkingSpaceHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    var parkingspace = await repo.getAll();

    for (var parkingspace in parkingspace) {
      if (parkingspace.id == id) {
        return Response.ok(
          jsonEncode(parkingspace.toJson()),
          headers: {'Content-Type': 'application/json'},
        );
      }
    }

    return Response.notFound(
      'ParkingSpace with id $id not found',
      headers: {'Content-Type': 'application/json'},
    );
  }

  // better error handling could be implemented
  return Response.badRequest();
}

Future<Response> updateParkingSpaceHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    final data = await request.readAsString();
    final json = jsonDecode(data);
    ParkingSpace? parkingspace = ParkingSpace.fromJson(json);

    await repo.update(id,parkingspace);

    return Response.ok(
      jsonEncode(parkingspace.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  // TODO: Implement better error handling
  return Response.badRequest();
}

Future<Response> deleteParkingSpaceHandler(Request request) async {
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
        'ParkingSpace with id $id not found',
        headers: {'Content-Type': 'application/json'},
      );
    }
  }

  // TODO: Implement better error handling
  return Response.badRequest();
}