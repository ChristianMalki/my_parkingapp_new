import 'dart:io';

import 'package:my_parkingapp_new/Repositories/PersonRepository.dart';
import 'package:my_parkingapp_new/models/person.dart';
import 'package:my_parkingapp_new/utils/validator.dart';
import 'package:uuid/uuid.dart';

PersonRepository repository = PersonRepository.instance;

class PersonsOperations {
  static create() {
    print('Enter name: ');

    var name = stdin.readLineSync();

    print('Enter new personnummer');
    var personnummer = stdin.readLineSync();
    if (Validator.isString(name)&& Validator.isString(personnummer)) {
      Person person = Person(id:Uuid().v4(), name: name!, personnummer: personnummer!);
      repository.create(person);
      print('Person created');
    } else {
      print('Invalid input');
    }
  }

  static Future list() async   {
    List<Person> allPersons = await repository.getAll();
    for (int i = 0; i < allPersons.length; i++) {
      print('${i + 1}. ${allPersons[i].name} - ${allPersons[i].personnummer}');
    }
  }

  static Future update()async {
    print('Pick an index to update: ');
    List<Person> allPersons = await repository.getAll();
    for (int i = 0; i < allPersons.length; i++) {
      print('${i + 1}. ${allPersons[i].name} - ${allPersons[i].personnummer}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allPersons)) {
      int index = int.parse(input!) - 1;
      Person person = allPersons[index];

      print('Enter new name: ');
      var name = stdin.readLineSync();
      print('Enter new personnummer: ');
      var personnummer = stdin.readLineSync();

      if (Validator.isString(name)&& Validator.isString(personnummer)) {
        Person newPerson = Person(id: person.id, name: name!, personnummer: personnummer!);
        repository.update(allPersons[index].id, newPerson);
        print('Person updated');
      } else {
        print('Invalid input');
      }
    } else {
      print('Invalid input');
    }
  }

  static delete() async {
    print('Pick an index to delete: ');
    List<Person> allPersons = await repository.getAll();
    for (int i = 0; i < allPersons.length; i++) {
      print('${i + 1}. ${allPersons[i].name} -${allPersons[i].personnummer}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allPersons)) {
      int index = int.parse(input!) - 1;
      repository.delete(allPersons[index].id);
      print('Person deleted');
    } else {
      print('Invalid input');
    }
  }
}