import 'package:my_server/Repositories/FileRepository.dart';

import 'package:shared/shared.dart';

class PersonRepository extends FileRepository<Person> {
  PersonRepository() : super('items.json');

  @override
  Person fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return Person.fromJson(json);
  }

  @override
  String idFromType(Person person) {
    // TODO: implement idFromType
    return person.id;
  }

  @override
  Map<String, dynamic> toJson(Person person) {
    // TODO: implement toJson
    return person.toJson();
  }
}
