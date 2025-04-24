import 'dart:convert';

import 'package:my_server/Repositories/PersonRepository.dart';
import 'package:shared/shared.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
 
var repo = PersonRepository();

Future<Response> postPersonHandler(Request request) async {
  final data = await request.readAsString();
  final json = jsonDecode(data);
  var person = Person.fromJson(json);

  await repo.create(person);

  return Response.ok(
    jsonEncode(person.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getPersonsHandler(Request request) async {
  final persons = await repo.getAll();

  final payload = persons.map((e) => e.toJson()).toList();

  return Response.ok(
    jsonEncode(payload),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getPersonHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    var persons = await repo.getAll();

    for (var person in persons) {
      if (person.id == id) {
        return Response.ok(
          jsonEncode(person.toJson()),
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

Future<Response> updatePersonHandler(Request request) async {
  String? id = request.params["id"];

  if (id != null) {
    final data = await request.readAsString();
    final json = jsonDecode(data);
    Person? person = Person.fromJson(json);

    await repo.update(person.id,person);

    return Response.ok(
      jsonEncode(person.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  // TODO: Implement better error handling
  return Response.badRequest();
}

Future<Response> deletePersonHandler(Request request) async {
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
        'Person with name $id not found',
        headers: {'Content-Type': 'application/json'},
      );
    }
  }

  // TODO: Implement better error handling
  return Response.badRequest();
}
