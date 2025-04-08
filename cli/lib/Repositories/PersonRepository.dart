
import 'package:shared/shared.dart';

class PersonRepository{
  // singleton

  PersonRepository._internal();

  static final PersonRepository _instance = PersonRepository._internal();

  static PersonRepository get instance => _instance;

  final List<Person> _persons = [];

  
  Future<Person> create(Person person) async {
    _persons.add(person);
    return person;
  }

  
  Future<Person> getBy(String personnummer) async {
    return _persons.firstWhere((e) => e.personnummer == personnummer);
  }

  
  Future<List<Person>>getAll() async => List.from(_persons);


  Future<Person> update(String id, Person newPerson) async {
    var index = _persons.indexWhere((e) => e.id == id);
    if (index >= 0 && index < _persons.length) {
      _persons[index] = newPerson;
      return newPerson;
    }
    throw RangeError.index(index, _persons);
  }

  
  Future<Person> delete(String id) async {
    var index = _persons.indexWhere((e) => e.id == id);
    if (index >= 0 && index < _persons.length) {
      return _persons.removeAt(index);
    }
    throw RangeError.index(index, _persons);
  }
}
