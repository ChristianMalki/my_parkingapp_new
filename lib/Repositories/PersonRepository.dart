
import 'package:my_parkingapp_new/models/person.dart';

class PersonRepository{
  // singleton

  PersonRepository._internal();

  static final PersonRepository _instance = PersonRepository._internal();

  static PersonRepository get instance => _instance;

  final _persons = [];

  
  Person create(Person person) {
    _persons.add(person);
    return person;
  }

  
  Person getBy(String personnummer) {
    return _persons.firstWhere((e) => e.personnummer == personnummer);
  }

  
  List<Person> getAll() => List.from(_persons);


  Person update(String personnummer, Person newPerson) {
    var index = _persons.indexWhere((e) => e.personnummer == personnummer);
    if (index >= 0 && index < _persons.length) {
      _persons[index] = newPerson;
      return newPerson;
    }
    throw RangeError.index(index, _persons);
  }

  
  Person delete(String personnummer) {
    var index = _persons.indexWhere((e) => e.personnummer == personnummer);
    if (index >= 0 && index < _persons.length) {
      return _persons.removeAt(index);
    }
    throw RangeError.index(index, _persons);
  }
}
