
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared/shared.dart';

class PersonRepository {
  PersonRepository? get instance => null;

  Future add(Person person) async {
    // send item serialized as json over http to server at localhost:8080
    final uri = Uri.parse("http://localhost:8080/persons");

    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(person.toJson()));

    final json = jsonDecode(response.body);

    return Person.fromJson(json);
  }

  Future<List<Person>> getAll() async {
    final uri = Uri.parse("http://localhost:8080/persons");
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return (json as List).map((item) => Person.fromJson(item)).toList();
  }

  Future update(Person updatedPerson) async {
    // send item serialized as json over http to server at localhost:8080
    final uri =
        Uri.parse("http://localhost:8080/persons/${updatedPerson.id}");

    Response response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedPerson.toJson()));

    final json = jsonDecode(response.body);

    return Person.fromJson(json);
  }

  Future delete(String id) async {
    final uri = Uri.parse("http://localhost:8080/persons/${id}");

    Response response = await http.delete(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future create(Person person) async {
    // send item serialized as json over http to server at localhost:8080
    final uri = Uri.parse("http://localhost:8080/persons");

    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(person.toJson()));

    final json = jsonDecode(response.body);

    return Person.fromJson(json);
  }
}


