import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared/shared.dart';



class PersonRepository {

  @override
  Future<Person> getById(String id) async {
    final uri = Uri.parse("http://10.0.2.2:8080/person/${id}");

    Response response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return Person.fromJson(json);
  }

  @override
  Future<Person> create(Person person) async {
    // send parking serialized as json over http to server at 10.0.2.2:8080
    final uri = Uri.parse("http://10.0.2.2:8080/person");

    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(person.toJson()));

    final json = jsonDecode(response.body);

    return Person.fromJson(json);
  }

  @override
  Future<List<Person>> getAll() async {


    final uri = Uri.parse("http://10.0.2.2:8080/person");
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return (json as List).map((person) => Person.fromJson(person)).toList();
  }

  @override
  Future<Person> delete(String id) async {
    final uri = Uri.parse("http://10.0.2.2:8080/person/${id}");

    Response response = await http.delete(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return Person.fromJson(json);
  }

  @override
  Future<Person> update(String id, Person person) async {
    // send parking serialized as json over http to server at 10.0.2.2:8080
    final uri = Uri.parse("http://10.0.2.2:8080/person/${id}");

    Response response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(person.toJson()));

    final json = jsonDecode(response.body);

    return Person.fromJson(json);
  }
}